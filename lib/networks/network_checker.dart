import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../errors/error_handler.dart';


abstract class NetworkChecher {
  Future<bool> get isConnected;

  Future<bool> hasConnection();
}

class NetworkCheckerImpl implements NetworkChecher {
  final ConnectivityResult result = ConnectivityResult.none;

  @override
  Future<bool> hasConnection() async {
    try {
      final result = await InternetConnectionChecker().hasConnection;
      return result;
    } catch (e) {
      throw PluginException;
    }
  }

  @override
  Future<bool> get isConnected => hasConnection();
}
