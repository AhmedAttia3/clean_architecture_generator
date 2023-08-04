// ignore_for_file: depend_on_referenced_packages

import 'package:clean_architecture_generator/clean_architecture_generator.dart';
import 'package:dio/dio.dart';
import 'package:mabna/features/home/repository/models/product_model.dart';
import 'package:mabna/features/settings/repository/models/settings_model.dart';

import '../../../../../core/consts/constants.dart';
import '../../../../../core/cubit/base_response/base_response.dart';
import '../../models/question_model.dart';

part '../settings_remote_data_source.g.dart';

@GenerateArchitecture
@RestApi()
abstract class SettingsRemoteDataSource {
  factory SettingsRemoteDataSource(Dio dio, {String baseUrl}) =
      _SettingsRemoteDataSource;

  ///FunctionSet [productId]
  ///EmitSet [productId]
  ///TextController [type]
  @POST(Endpoints.saveProduct)
  Future<BaseResponse> saveProduct({
    @Field('productId') required String productId,
    @Field('type') required String type,
  });

  ///Prop [paging,cached]
  @GET(Endpoints.getSavedProducts)
  Future<double> getSavedProducts({
    @Query('page') required int page,
    @Query('limit') required int limit,
  });

  @GET(Endpoints.getSettings)
  Future<BaseResponse<SettingsModel?>> getSettings();

  @GET(Endpoints.getSettings)
  Future<BaseResponse<SettingsModel?>> getSengs();

  @GET(Endpoints.getQuestions)
  Future<BaseResponse<List<QuestionModel>?>> getQuestions();
}
