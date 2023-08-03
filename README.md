<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

TODO: List what your package can do. Maybe include images, gifs, or videos.

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

TODO: Include short and useful examples for package users. Add longer examples
to `/example` folder.

```dart

part '../settings_remote_data_source.g.dart';

@GenerateArchitecture ///[add this annotation]
@RestApi()
abstract class SettingsRemoteDataSource {
  factory SettingsRemoteDataSource(Dio dio, {String baseUrl}) =
  _SettingsRemoteDataSource;

  ///FunctionSet [productId]     
  ///TextController [type]
  @POST(Endpoints.saveProduct)
  Future<BaseResponse> saveProduct({
    @Field('productId') required String productId,
    @Field('type') required String type,
  });
  
}


```
```dart

///[SaveProductCubit]
///[Implementation]
@injectable
class SaveProductCubit extends Cubit<FlowState> {
  final SaveProductUseCase _saveProductUseCase;
  final GlobalKey<FormState> formKey;
  final TextEditingController type;

  SaveProductCubit(
      this._saveProductUseCase,
      this.formKey,
      this.type,
      ) : super(ContentState());

  String productId = "";

  Future<void> execute() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingState(type: StateRendererType.popUpLoading));
      final res = await _saveProductUseCase.execute(
          request: SaveProductRequest(
            type: type.text,
            productId: productId,
          ));
      res.left((failure) {
        emit(ErrorState(
          type: StateRendererType.toastError,
          message: failure.message,
        ));
      });
      res.right((data) {
        if (data.success) {
          emit(SuccessState(
            message: data.message,
            type: StateRendererType.contentState,
          ));
        } else {
          emit(SuccessState(
            message: data.message,
            type: StateRendererType.toastError,
          ));
        }
      });
    }
  }

  void setProductId(String value) {
    productId = value;
  }
}

```
```dart

part '../settings_remote_data_source.g.dart';

@GenerateArchitecture ///[add this annotation]
@RestApi()
abstract class SettingsRemoteDataSource {
  factory SettingsRemoteDataSource(Dio dio, {String baseUrl}) =
  _SettingsRemoteDataSource;

  ///Prop [paging,cached]
  @GET(Endpoints.getSavedProducts)
  Future<double> getSavedProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });
  
}


```

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
