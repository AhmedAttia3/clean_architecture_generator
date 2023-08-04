## Generator description role

Clean architecture generator used for build a code from retrofit services file.
Use for generate use-case, repositories, requests, cubits and unit test for all of this.
And can use comments above functions in retrofit file to build cubit with different properties like
variable come from TextEditingController, function for set value of variable, cache the return value
in sharedPreferences and make cubit used this usecase with pagination controller like pagewise.

## Platform support

| Dart | Flutter |
| :--: |   :-:   |
| ✅ | ✅ |

## Generated code for unit rest

<p>
 <img src="https://github.com/ibrahimnashat/clean_architecture_generator/blob/master/images/Screenshot%202023-08-03%20221114.png"/>
</p>

## Generated code for repository, usecase, requests and cubits

<p>
 <img src="https://github.com/ibrahimnashat/clean_architecture_generator/blob/master/images/Screenshot%202023-08-03%20221136.png"/>
</p>

## Example

```dart 
///[add import]
import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:dio/dio.dart';
import 'package:mabna/features/home/repository/models/product_model.dart';
import 'package:mabna/features/settings/repository/models/settings_model.dart';

import '../../../../../core/consts/constants.dart';
import '../../../../../core/cubit/base_response/base_response.dart';
import '../../models/question_model.dart';

part '../settings_remote_data_source.g.dart';


///[add annotaion]
@GenerateArchitecture
@RestApi()
abstract class SettingsRemoteDataSource {
  factory SettingsRemoteDataSource(Dio dio, {String baseUrl}) =
      _SettingsRemoteDataSource;

  //[add FunctionSet above function]
  //[add variable name from function to make method for set value of it]
  //[add TextController above function]
  //[add variable name from function to make TextEditingController for it]
  //[And passing it to useCase in cubit with it dataType like int or double or String or num]
  //[It will be parsing to dataType of variable]

  ///FunctionSet [productId]
  ///TextController [type]
  @POST(Endpoints.saveProduct)
  Future<BaseResponse> saveProduct({
    @Field('productId') required String productId,
    @Field('type') required String type,
  });
  
  //[paging inside Prop to generate cubit with pagination controller]
  //[cached inside Prop to generate usecase for cache other to get cache]
  //[And cubit for get cache from usecase]

  ///Prop [paging,cached]
  @GET(Endpoints.getSavedProducts)
  Future<double> getSavedProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @GET(Endpoints.getSettings)
  Future<BaseResponse<SettingsModel?>> getSettings();

  @GET(Endpoints.getQuestions)
  Future<BaseResponse<List<QuestionModel>?>> getQuestions();
}
```
## Generated Cubit with properties

```dart

///[SaveProductCubit]
///[Implementation]
@injectable
class SaveProductCubit extends Cubit<FlowState> {
  final SaveProductUseCase _saveProductUseCase;
  final GlobalKey<FormState> formKey;
  final TextEditingController type;

  SaveProductCubit(this._saveProductUseCase,
      this.formKey,
      this.type,) : super(ContentState());

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
## Generated Cubit without properties

```dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:mabna/core/consts/fold.dart';
import 'package:mabna/core/cubit/state_renderer/state_renderer.dart';
import 'package:mabna/core/cubit/state_renderer/states.dart';
import 'package:mabna/features/settings/repository/models/question_model.dart';
import 'package:mabna/features/test/repository/use-cases/get_questions_use_case.dart';

///[GetQuestionsCubit]
///[Implementation]
@injectable
class GetQuestionsCubit extends Cubit<FlowState> {
  final GetQuestionsUseCase _getQuestionsUseCase;

  GetQuestionsCubit(this._getQuestionsUseCase,) : super(ContentState());

  List<QuestionModel> questions = [];

  Future<void> execute() async {
    emit(LoadingState(type: StateRendererType.popUpLoading));
    final res = await _getQuestionsUseCase.execute();
    res.left((failure) {
      emit(ErrorState(
        type: StateRendererType.toastError,
        message: failure.message,
      ));
    });
    res.right((data) {
      if (data.success) {
        if (data.data != null) {
          questions = data.data!;
        }
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


```
## Generated request for useCase

```dart

import 'package:json_annotation/json_annotation.dart';

part 'save_product_request.g.dart';

///[SaveProductRequest]
///[Implementation]
@JsonSerializable()
class SaveProductRequest {
  final String productId;
  final String type;

  const SaveProductRequest({
    required this.productId,
    required this.type,
  });

  factory SaveProductRequest.fromJson(Map<String, dynamic> json) =>
      _$SaveProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SaveProductRequestToJson(this);
}

```

## Generated useCase

```dart

///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:injectable/injectable.dart';
import 'package:mabna/core/base_use_case.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/failure.dart';
import 'package:mabna/features/test/repository/data-source/test_remote_data_source_repository.dart';
import 'package:mabna/features/test/repository/requests/save_product_request.dart';

///[SaveProductUseCase]
///[Implementation]
@injectable
class SaveProductUseCase
    implements
        BaseUseCase<Future<Either<Failure, BaseResponse<dynamic>>>,
            SaveProductRequest> {
  final TestRemoteDataSourceRepository repository;

  const SaveProductUseCase(
      this.repository,
      );

  @override
  Future<Either<Failure, BaseResponse<dynamic>>> execute({
    SaveProductRequest? request,
  }) async {
    return await repository.saveProduct(
      productId: request!.productId,
      type: request!.type,
    );
  }
}


```
## Generated abstract repository

```dart
import 'package:eitherx/eitherx.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/failure.dart';
import 'package:mabna/features/home/repository/models/product_model.dart';
import 'package:mabna/features/settings/repository/models/question_model.dart';
import 'package:mabna/features/settings/repository/models/settings_model.dart';

///[Implementation]
abstract class TestRemoteDataSourceRepository {
  Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({
    required String productId,
    required String type,
  });

  Future<Either<Failure, BaseResponse<List<ProductModel>?>>> getSavedProducts({
    required int page,
    required int limit,
  });

  Future<Either<Failure, Unit>> cacheSavedProducts({
    required List<ProductModel> data,
  });

  Either<Failure, List<ProductModel>> getCacheSavedProducts();

  Future<Either<Failure, BaseResponse<SettingsModel?>>> getSettings();

  Future<Either<Failure, BaseResponse<List<QuestionModel>?>>> getQuestions();
}


```
## Generated repository implementation

```dart
import 'dart:convert';

import 'package:eitherx/eitherx.dart';
import 'package:injectable/injectable.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/cubit/safe_request_handler.dart';
import 'package:mabna/core/failure.dart';
import 'package:mabna/features/home/repository/models/product_model.dart';
import 'package:mabna/features/settings/repository/models/question_model.dart';
import 'package:mabna/features/settings/repository/models/settings_model.dart';
import 'package:mabna/features/test/repository/data-source/test_remote_data_source_repository.dart';
import 'package:mabna/features/test/test_remote_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

///[TestRemoteDataSourceRepositoryImplement]
///[Implementation]
@Injectable(as: TestRemoteDataSourceRepository)
class TestRemoteDataSourceRepositoryImplement
    implements TestRemoteDataSourceRepository {
  final TestRemoteDataSource testRemoteDataSource;
  final SafeApi api;
  final SharedPreferences sharedPreferences;

  const TestRemoteDataSourceRepositoryImplement(
      this.testRemoteDataSource,
      this.api,
      this.sharedPreferences,
      );

  @override
  Future<Either<Failure, BaseResponse<dynamic>>> saveProduct({
    required String productId,
    required String type,
  }) async {
    return await api<BaseResponse<dynamic>>(
      apiCall: testRemoteDataSource.saveProduct(
        productId: productId,
        type: type,
      ),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<List<ProductModel>?>>> getSavedProducts({
    required int page,
    required int limit,
  }) async {
    return await api<BaseResponse<List<ProductModel>?>>(
      apiCall: testRemoteDataSource.getSavedProducts(
        page: page,
        limit: limit,
      ),
    );
  }

  final _savedProducts = "SAVEDPRODUCTS";

  @override
  Future<Either<Failure, Unit>> cacheSavedProducts({
    required List<ProductModel> data,
  }) async {
    try {
      await sharedPreferences.setString(_savedProducts,
          jsonEncode(data.map((item) => item.toJson()).toList()));
      return const Right(unit);
    } catch (e) {
      return Left(Failure(12, 'Cash failure'));
    }
  }

  @override
  Either<Failure, List<ProductModel>> getCacheSavedProducts() {
    try {
      final res = sharedPreferences.getString(_savedProducts) ?? '{}';
      List<ProductModel> data = [];
      for (var item in jsonDecode(res)) {
        data.add(ProductModel.fromJson(item));
      }
      return Right(data);
    } catch (e) {
      return Left(Failure(12, 'Cash failure'));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<SettingsModel?>>> getSettings() async {
    return await api<BaseResponse<SettingsModel?>>(
      apiCall: testRemoteDataSource.getSettings(),
    );
  }

  @override
  Future<Either<Failure, BaseResponse<List<QuestionModel>?>>>
  getQuestions() async {
    return await api<BaseResponse<List<QuestionModel>?>>(
      apiCall: testRemoteDataSource.getQuestions(),
    );
  }
}


```

## Generated unit test for repository

```dart
import 'package:eitherx/eitherx.dart';
import 'package:mabna/features/home/repository/models/product_model.dart';
import 'package:mabna/features/settings/repository/models/question_model.dart';
import 'package:mabna/features/settings/repository/models/settings_model.dart';
import 'package:mabna/core/consts/constants.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/failure.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:mabna/core/consts/fold.dart';
import 'package:mabna/core/cubit/safe_request_handler.dart';
import 'package:mabna/core/base_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mabna/features/test/test_remote_data_source.dart';
import 'package:mabna/features/test/repository/data-source/test_remote_data_source_repository_impl.dart';
import 'package:mabna/features/test/repository/data-source/test_remote_data_source_repository.dart';
import 'package:mabna/core/framework/network.dart';

import 'test_remote_data_source_repository_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TestRemoteDataSource>(),
  MockSpec<NetworkInfo>(),
  MockSpec<SharedPreferences>(),
])
void main() {
  late TestRemoteDataSource dataSource;
  late TestRemoteDataSourceRepository repository;
  late SafeApi apiCall;
  late NetworkInfo networkInfo;
  late SharedPreferences sharedPreferences;
  late BaseResponse<dynamic> saveProductResponse;
  late BaseResponse<List<ProductModel>?> getSavedProductsResponse;
  late List<ProductModel> productModels;
  late BaseResponse<SettingsModel?> getSettingsResponse;
  late BaseResponse<List<QuestionModel>?> getQuestionsResponse;
  setUp(() {
    sharedPreferences = MockSharedPreferences();
    networkInfo = MockNetworkInfo();
    apiCall = SafeApi(networkInfo);
    dataSource = MockTestRemoteDataSource();
    repository = TestRemoteDataSourceRepositoryImplement(
      dataSource,
      apiCall,
      sharedPreferences,
    );

    ///[SaveProduct]
    saveProductResponse = BaseResponse<dynamic>(
      message: 'message',
      success: true,
      data: null,);

    ///[GetSavedProducts]
    getSavedProductsResponse = BaseResponse<List<ProductModel>?>(
        message: 'message',
        success: true,
        data: List.generate(
          2,
              (index) =>
              ProductModel.fromJson(fromJson('expected_product_model')),
        ));
    productModels = List.generate(
      2,
          (index) =>
          ProductModel.fromJson(fromJson('expected_product_model')),
    );

    ///[GetSettings]
    getSettingsResponse = BaseResponse<SettingsModel?>(
      message: 'message',
      success: true,
      data: SettingsModel.fromJson(fromJson('expected_settings_model')),);

    ///[GetQuestions]
    getQuestionsResponse = BaseResponse<List<QuestionModel>?>(
        message: 'message',
        success: true,
        data: List.generate(
          2,
              (index) =>
              QuestionModel.fromJson(fromJson('expected_question_model')),
        ));
  });
  saveProduct() =>
      dataSource.saveProduct(productId: "productId", type: "type",);
  getSavedProducts() => dataSource.getSavedProducts(page: 2, limit: 2,);
  cacheSavedProducts() =>
      sharedPreferences.setString('SAVEDPRODUCTS',
        jsonEncode(productModels.map((item) =>
            item.toJson()).toList()),);

  getCacheSavedProducts() => sharedPreferences.getString('SAVEDPRODUCTS');

  getSettings() => dataSource.getSettings();
  getQuestions() => dataSource.getQuestions();
  group('TestRemoteDataSourceRepository Repository', () {
    ///[No Internet Test]
    test('No Internet', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      final res = await repository.saveProduct(
        productId: "productId", type: "type",);
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verifyNoMoreInteractions(networkInfo);
    });

    ///[saveProduct Success Test]
    test('saveProduct Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(saveProduct())
          .thenAnswer((realInvocation) async => saveProductResponse);
      final res = await repository.saveProduct(
        productId: "productId", type: "type",);
      expect(res.rightOrNull(), saveProductResponse);
      verify(networkInfo.isConnected);
      verify(saveProduct());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[saveProduct Failure Test]
    test('saveProduct Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(saveProduct())
          .thenAnswer((realInvocation) async => saveProductResponse);
      final res = await repository.saveProduct(
        productId: "productId", type: "type",);
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(saveProduct());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSavedProducts Success Test]
    test('getSavedProducts Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getSavedProducts())
          .thenAnswer((realInvocation) async => getSavedProductsResponse);
      final res = await repository.getSavedProducts(page: 2, limit: 2,);
      expect(res.rightOrNull(), getSavedProductsResponse);
      verify(networkInfo.isConnected);
      verify(getSavedProducts());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSavedProducts Failure Test]
    test('getSavedProducts Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getSavedProducts())
          .thenAnswer((realInvocation) async => getSavedProductsResponse);
      final res = await repository.getSavedProducts(page: 2, limit: 2,);
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getSavedProducts());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[cacheSavedProducts Test]
    test('cacheSavedProducts', () async {
      when(cacheSavedProducts()).thenAnswer((realInvocation) async => true);
      final res = await repository.cacheSavedProducts(data: productModels);
      expect(res.rightOrNull(), unit);
      verify(cacheSavedProducts());
      verifyNoMoreInteractions(sharedPreferences);
    });

    ///[getCacheSavedProducts Test]
    test('getCacheSavedProducts', () async {
      when(getCacheSavedProducts()).thenAnswer((realInvocation) =>
          jsonEncode(productModels.map((item) =>
              item.toJson()).toList()),);

      final res = repository.getCacheSavedProducts();
      expect(res.rightOrNull(), isA<List<ProductModel>>());
      verify(getCacheSavedProducts());
      verifyNoMoreInteractions(sharedPreferences);
    });

    ///[getSettings Success Test]
    test('getSettings Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getSettings())
          .thenAnswer((realInvocation) async => getSettingsResponse);
      final res = await repository.getSettings();
      expect(res.rightOrNull(), getSettingsResponse);
      verify(networkInfo.isConnected);
      verify(getSettings());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getSettings Failure Test]
    test('getSettings Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getSettings())
          .thenAnswer((realInvocation) async => getSettingsResponse);
      final res = await repository.getSettings();
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getSettings());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getQuestions Success Test]
    test('getQuestions Success', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => true);
      when(getQuestions())
          .thenAnswer((realInvocation) async => getQuestionsResponse);
      final res = await repository.getQuestions();
      expect(res.rightOrNull(), getQuestionsResponse);
      verify(networkInfo.isConnected);
      verify(getQuestions());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });

    ///[getQuestions Failure Test]
    test('getQuestions Failure', () async {
      when(networkInfo.isConnected).thenAnswer((realInvocation) async => false);
      when(getQuestions())
          .thenAnswer((realInvocation) async => getQuestionsResponse);
      final res = await repository.getQuestions();
      expect(res.leftOrNull(), isA<Failure>());
      verify(networkInfo.isConnected);
      verify(getQuestions());
      verifyNoMoreInteractions(networkInfo);
      verifyNoMoreInteractions(dataSource);
    });
  });
}

///[FromJson]
Map<String, dynamic> fromJson(String path) {
  return jsonDecode(File('test/expected/$path.json').readAsStringSync());
}

```

## Generated unit test for one of useCases

```dart
import 'package:eitherx/eitherx.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mabna/core/consts/fold.dart';
import 'package:mabna/core/cubit/base_response/base_response.dart';
import 'package:mabna/core/failure.dart';
import 'package:mabna/features/test/repository/data-source/test_remote_data_source_repository.dart';
import 'package:mabna/features/test/repository/requests/save_product_request.dart';
import 'package:mabna/features/test/repository/use-cases/save_product_use_case.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_product_use_case_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<TestRemoteDataSourceRepository>(),
])
void main() {
  late SaveProductUseCase saveProductUseCase;
  late TestRemoteDataSourceRepository repository;
  late BaseResponse<dynamic> success;
  late Failure failure;
  setUp(() {
    repository = MockTestRemoteDataSourceRepository();
    saveProductUseCase = SaveProductUseCase(repository);
    failure = Failure(1, 'message');
    success = BaseResponse<dynamic>(
      message: 'message',
      success: true,
      data: null,
    );
  });

  webService() =>
      repository.saveProduct(
        productId: "productId",
        type: "type",
      );

  group('SaveProductUseCase ', () {
    test('saveProduct FAILURE', () async {
      when(webService()).thenAnswer((realInvocation) async => Left(failure));
      final res = await saveProductUseCase.execute(
          request: const SaveProductRequest(
            productId: "productId",
            type: "type",
          ));
      expect(res.left((data) {}), failure);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });

    test('saveProduct SUCCESS', () async {
      when(webService()).thenAnswer((realInvocation) async => Right(success));
      final res = await saveProductUseCase.execute(
          request: const SaveProductRequest(
            productId: "productId",
            type: "type",
          ));
      expect(res.right((data) {}), success);
      verify(webService());
      verifyNoMoreInteractions(repository);
    });
  });
}


```

#### License

This library is distributed under Apache 2.0 license for more info see [LICENSE DETAILS](./LICENSE)
