///[Network]
///[Implementation]
import 'package:eitherx/eitherx.dart';
import 'package:example/core/base_response.dart';
import 'package:example/settings/models/product_model.dart';
import 'package:example/settings/models/settings_model.dart';
import 'package:example/core/base_response.dart';
import 'package:injectable/injectable.dart';
import 'package:injectable/injectable.dart';import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class NetworkInfo {
Future<bool> get isConnected;
}


@Injectable(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
InternetConnectionChecker internetConnectionChecker;
NetworkInfoImpl(this.internetConnectionChecker);
@override
Future<bool> get isConnected => internetConnectionChecker.hasConnection;
}
