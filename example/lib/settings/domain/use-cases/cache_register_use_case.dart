import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:example/settings/domain/repository/settings_repository.dart';
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

///[CacheRegisterUseCase]
///[Implementation]
@injectable
class CacheRegisterUseCase implements BaseUseCase<Future<Either<Failure, Unit>>,UserModel> {
final SettingsRepository repository;
const CacheRegisterUseCase(
this.repository,
);

@override
Future<Either<Failure, Unit>> execute({UserModel? request,}) async {
if(request != null){
return await repository.cacheRegister
(data: request);
}
return const Right(unit);
}

}

