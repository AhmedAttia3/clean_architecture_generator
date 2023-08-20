import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:example/settings/domain/repository/settings_repository.dart';
import 'package:example/settings/domain/use-cases/get_cache_register_use_case.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/entities/user_entity.dart';
import 'package:example/settings/data/models/user_model.dart';
import 'package:example/settings/domain/entities/address_entity.dart';
import 'package:example/settings/data/models/address_model.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/data/models/otp_model.dart';
import 'package:example/settings/domain/entities/otp_entity.dart';
import 'package:example/settings/data/models/otp_model.dart';

///[GetCacheRegisterUseCase]
///[Implementation]
@injectable
class GetCacheRegisterUseCase implements BaseUseCase<Either<Failure, UserEntity>, Void?>{
final SettingsRepository repository;
const GetCacheRegisterUseCase(
this.repository,
);

@override
Either<Failure, UserEntity> execute({Void? request,}) {
return repository.getCacheRegister();
}

}

