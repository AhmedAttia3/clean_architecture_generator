///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/core/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:example/core/base_use_case.dart';
import 'package:example/home/domain/repository/home_repository.dart';
import 'package:example/home/domain/requests/get_result_request.dart';
import 'package:example/home/domain/entities/governorate_entity.dart';
import 'package:example/home/domain/entities/result_entity.dart';
import 'package:example/home/domain/entities/device_settings_entity.dart';

///[GetResultUseCase]
///[Implementation]
@injectable
class GetResultUseCase implements BaseUseCase<Future<Either<Failure, BaseResponse<ResultEntity?>>>,GetResultRequest>{
final HomeRepository repository;
const GetResultUseCase(
this.repository,
);

@override
Future<Either<Failure, BaseResponse<ResultEntity?>>> execute({GetResultRequest? request,}) async {
return await repository.getResult
(countryId: request!.countryId,termId: request!.termId,studentName: request!.studentName,sittingNumber: request!.sittingNumber,);
}

}

