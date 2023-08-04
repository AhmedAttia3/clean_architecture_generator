///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'dart:ffi';
import 'package:example/test/repository/data-source/settings_remote_data_source_repository.dart';

///[GetSettingsUseCase]
///[Implementation]
@injectable
class GetSettingsUseCase implements BaseUseCase<Future<Either<Failure, InvalidType>>,Void>{
final SettingsRemoteDataSourceRepository repository;
const GetSettingsUseCase(
this.repository,
);

@override
Future<Either<Failure, InvalidType>> execute({Void? request,}) async {
return await repository.getSettings
();
}

}

