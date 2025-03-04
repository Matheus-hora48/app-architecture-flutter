import 'package:app_architecture_flutter/data/repositories/auth/auth_repository.dart';
import 'package:app_architecture_flutter/data/repositories/auth/remote_auth_repository.dart';
import 'package:app_architecture_flutter/data/services/auth/auth_client_http.dart';
import 'package:app_architecture_flutter/data/services/auth/auth_local_storage.dart';
import 'package:app_architecture_flutter/core/client_http/client_http.dart';
import 'package:app_architecture_flutter/core/local_storage/local_storage.dart';
import 'package:auto_injector/auto_injector.dart';

final injector = AutoInjector();

void setupDependencies(){
  injector.addSingleton<AuthRepository>(RemoteAuthRepository.new);
  injector.addSingleton(ClientHttp.new);
  injector.addSingleton(LocalStorage.new);
  injector.addSingleton(AuthClientHttp.new);
  injector.addSingleton(AuthLocalStorage.new);
}