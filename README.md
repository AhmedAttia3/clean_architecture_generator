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

Clean architecture generator used for build a code from retrofit services file.
Use for generate use-case, repositories, requests, cubits and unit test for all of this.
And can use comments above functions in retrofit file to build cubit with different properties like variable come from TextEditingController, function for set value of variable, cache the return value in sharedPreferences and make cubit used this usecase with pagination controller like pagewise.

### Platform Support

| Dart | Flutter |
| :--: |   :-:   | 
|  ✅  |    ✅    | 

## Features
<img alt="Generated Code" src="https://github.com/ibrahimnashat/clean_architecture_generator/blob/master/images/Screenshot%202023-08-03%20221136.png" width="300" height="100"/>
<img alt="Generated Unit test for Code" src="https://github.com/ibrahimnashat/clean_architecture_generator/blob/master/images/Screenshot%202023-08-03%20221114.png" width="300" height="100"/>



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

#### License

This library is distributed under Apache 2.0 license for more info see [LICENSE DETAILS](./LICENSE)
