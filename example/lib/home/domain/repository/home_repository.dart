import 'package:eitherx/eitherx.dart';
import 'package:mwidgets/mwidgets.dart';
import 'package:example/core/base/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base/base_use_case.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/data/models/governorate_model.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/data/models/result_model.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';
import 'package:example/home/data/models/device_settings_model.dart';

///[Implementation]
abstract class HomeRepository {
Future<Either<Failure, BaseResponse<List<GovernorateEntity>?>>> getGovernorates();
Future<Either<Failure, BaseResponse<ResultEntity?>>> getResult({required int countryId,required int termId,required String studentName,required String sittingNumber, });
Future<Either<Failure, BaseResponse<int>>> addFavorite({required int countryId, });
Future<Either<Failure, BaseResponse<DeviceSettingsEntity?>>> updateUser({required int firebaseToken, });
}

