///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/domain/requests/register_request.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';

///[RegisterUseCase]
///[Implementation]
@injectable
class RegisterUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<UserEntity?>>>,RegisterRequest>{
final SettingsRepository repository;
const RegisterUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<UserEntity?>>> execute({RegisterRequest? request,}) async {
return await repository.register
(fullName: request!.fullName,phone: request!.phone,email: request!.email,password: request!.password,id: request!.id,);
}

}

