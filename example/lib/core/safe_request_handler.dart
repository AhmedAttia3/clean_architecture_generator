///[SafeApi]
///[Implementation]
import 'dart:developer';

import 'package:eitherx/eitherx.dart';
import 'package:eitherx/eitherx.dart';
import 'package:example/core/print.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:injectable/injectable.dart';
import 'package:injectable/injectable.dart';

@injectable
class SafeApi {
  final NetworkInfo networkInfo;

  SafeApi(this.networkInfo);

  Future<Either<Failure, T>> call<T>({
    required Future<T> apiCall,
  }) async {
    final hasConnection = await networkInfo.isConnected;
    if (hasConnection) {
      try {
        final response = await apiCall;
        return Right(response);
      } catch (error) {
        kPrint("API Error: $error");
        return Left(Failure(600, error.toString()));
      }
    } else {
      return Left(Failure(500, 'No Internet'));
    }
  }
}
