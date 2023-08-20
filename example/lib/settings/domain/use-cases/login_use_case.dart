///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/domain/requests/login_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[LoginUseCase]
///[Implementation]
@injectable
class LoginUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<UserEntity?>>>,LoginRequest>{
final SettingsRepository repository;
const LoginUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<UserEntity?>>> execute({LoginRequest? request,}) async {
return await repository.login
(request : request!);
}

}

