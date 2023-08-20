///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/domain/requests/get_otps_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[GetOTPsUseCase]
///[Implementation]
@injectable
class GetOTPsUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<List<OtpEntity>?>>>,GetOTPsRequest>{
final SettingsRepository repository;
const GetOTPsUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<List<OtpEntity>?>>> execute({GetOTPsRequest? request,}) async {
return await repository.getOTPs
(page: request!.page,limit: request!.limit,userId: request!.userId,);
}

}

