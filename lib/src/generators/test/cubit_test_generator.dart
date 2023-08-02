import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:generators/formatter/method_format.dart';
import 'package:generators/formatter/names.dart';
import 'package:generators/src/mvvm_generator_annotations.dart';
import 'package:source_gen/source_gen.dart';

import '../../model_visitor.dart';

class CubitTestGenerator extends GeneratorForAnnotation<MVVMAnnotation> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final visitor = ModelVisitor();
    final names = Names();
    final methodFormat = MethodFormat();
    element.visitChildren(visitor);
    final haveKeyValidator =
        visitor.params.values.contains('GlobalKey<FormState>');

    final classBuffer = StringBuffer();
    final repository = names.firstLower(visitor.className);
    classBuffer.writeln('@GenerateNiceMocks([');
    for (var param in visitor.paramsType) {
      classBuffer.writeln('MockSpec<$param>(),');
    }
    if (haveKeyValidator) {
      classBuffer.writeln('MockSpec<FormState>(),');
    }
    classBuffer.writeln('])');
    classBuffer.writeln('void main() {');
    classBuffer.writeln("late ${visitor.className} cubit;");
    for (var param in visitor.params.entries) {
      classBuffer.writeln('late ${param.value} ${param.key};');
    }
    if (haveKeyValidator) {
      classBuffer.writeln('late FormState formState;');
    }
    classBuffer.writeln('setUp(() async {');
    for (var param in visitor.params.entries) {
      classBuffer.writeln('${param.key} = Mock${param.value}();');
    }
    if (haveKeyValidator) {
      classBuffer.writeln('formState = MockFormState();');
    }

    ///[cubit init start]
    classBuffer.writeln('cubit = ${visitor.className}(');
    for (var param in visitor.constructorParams) {
      classBuffer.writeln('${param.name},');
    }
    classBuffer.writeln(');');

    ///[cubit init end]
    classBuffer.writeln('});');

    ///[test]
    classBuffer.writeln("group('${visitor.className} CUBIT', () {");
    for (var fun in visitor.useCases) {
      classBuffer.writeln("blocTest<${visitor.className}, FlowState>(");
      classBuffer.writeln("'${fun.name} METHOD',");
      classBuffer.writeln("build: () => cubit,");
      classBuffer.writeln("act: (cubit) {");
      classBuffer.writeln(
          "when(${fun.name}.execute()).thenAnswer((realInvocation) => Right(successResponse));");
      classBuffer.writeln("cubit.${fun.name}();");
      classBuffer.writeln("},");
      classBuffer.writeln("expect: () => <FlowState>[");
      classBuffer.writeln("],");
      classBuffer.writeln(");");

      classBuffer.writeln("print('${fun.declaration.toString()}');");
      classBuffer.writeln("print('${fun.parameters.toString()}');");

//

//         ContentState(data: user),
//
//     );
    }
    classBuffer.writeln('});');
    classBuffer.writeln('}');
    return classBuffer.toString();
  }
}

//   late BaseResponse<UserModel?> response;
//   late UserModel user;
//
//   setUp(() async {
//     editProfileRequest = EditProfileRequest(
//       phone: 'phone',
//       email: 'email',
//       fullName: 'fullName',
//     );
//     user = UserModel.fromJson(Encode.set('expected_user_model'));
//     response = BaseResponse<UserModel?>.fromJson(
//       Encode.set('expected_auth_success_response'),
//           (json) => UserModel.fromJson(json as Map<String, dynamic>),
//     );
//
//   });
//
//   group('EditProfileCubit CUBIT', () {
//     blocTest<EditProfileCubit, FlowState>(
//       'getProfile METHOD',
//       build: () => cubit,
//       act: (cubit) {
//         when(getProfile.execute()).thenAnswer((realInvocation) => Right(user));
//
//         cubit.info();
//       },
//       expect: () => <FlowState>[
//         ContentState(data: user),
//       ],
//     );
//
//     blocTest<EditProfileCubit, FlowState>(
//       'editProfile validation false METHOD',
//       build: () => cubit,
//       act: (cubit) {
//         when(key.currentState).thenAnswer((realInvocation) => formState);
//         when(formState.validate()).thenAnswer((realInvocation) => false);
//         when(cubit.isChanged()).thenAnswer((realInvocation) => false);
//       },
//       expect: () => <FlowState>[],
//     );
//
//     blocTest<EditProfileCubit, FlowState>(
//       'editProfile success true status METHOD',
//       build: () => cubit,
//       act: (cubit) {
//         when(key.currentState).thenAnswer((realInvocation) => formState);
//         when(formState.validate()).thenAnswer((realInvocation) => true);
//         when(saveProfile.execute(user: user))
//             .thenAnswer((realInvocation) async => const Right(unit));
//         when(editProfile.execute(request: editProfileRequest))
//             .thenAnswer((realInvocation) async => Right(response));
//
//         cubit.editProfile(
//           onPhoneChanged: () {},
//           onEmailChanged: () {},
//           onNameOrNoThing: () {},
//         );
//       },
//       expect: () => <FlowState>[
//         LoadingState(type: StateRendererType.popUpLoading),
//         SuccessState(
//             message: 'User Logged In sucssfully',
//             type: StateRendererType.contentState)
//       ],
//     );
//
//     blocTest<EditProfileCubit, FlowState>(
//       'editProfile success false status METHOD',
//       build: () => cubit,
//       act: (cubit) {
//         when(key.currentState).thenAnswer((realInvocation) => formState);
//         when(formState.validate()).thenAnswer((realInvocation) => true);
//         when(editProfile.execute(request: editProfileRequest)).thenAnswer(
//                 (realInvocation) async => Right(response..success = false));
//
//         cubit.editProfile(
//           onPhoneChanged: () {},
//           onEmailChanged: () {},
//           onNameOrNoThing: () {},
//         );
//       },
//       expect: () => <FlowState>[
//         LoadingState(type: StateRendererType.popUpLoading),
//         ErrorState(
//             type: StateRendererType.toastError,
//             message: 'User Logged In sucssfully')
//       ],
//     );
//
//     blocTest<EditProfileCubit, FlowState>(
//       'editProfile failure METHOD',
//       build: () => cubit,
//       act: (cubit) {
//         when(key.currentState).thenAnswer((realInvocation) => formState);
//         when(formState.validate()).thenAnswer((realInvocation) => true);
//         when(editProfile.execute(request: editProfileRequest))
//             .thenAnswer((realInvocation) async => Left(Failure(0, 'message')));
//
//         cubit.editProfile(
//           onPhoneChanged: () {},
//           onEmailChanged: () {},
//           onNameOrNoThing: () {},
//         );
//       },
//       expect: () => <FlowState>[
//         LoadingState(type: StateRendererType.popUpLoading),
//         ErrorState(type: StateRendererType.toastError, message: 'message')
//       ],
//     );
//   });
