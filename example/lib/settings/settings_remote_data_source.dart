// ignore_for_file: depend_on_referenced_packages

import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:dio/dio.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:retrofit/retrofit.dart';

part 'settings_remote_data_source.g.dart';

@GenerateArchitecture
@RestApi()
abstract class SettingsRemoteDataSource {
  factory SettingsRemoteDataSource(Dio dio, {String baseUrl}) =
      _SettingsRemoteDataSource;

  ///FunctionSet [productId]
  ///EmitSet [productId]
  ///TextController [type]
  @POST("saveProduct")
  Future<BaseResponse> saveProduct({
    @Field('productId') required String productId,
    @Field('type') required String type,
  });

  ///Prop [paging]
  @GET("getSavedProducts")
  Future<BaseResponse<ProductModel?>> getSavedProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  ///Prop [cached]
  @GET("getSettings")
  Future<BaseResponse<SettingsModel?>> getSettings();
}
