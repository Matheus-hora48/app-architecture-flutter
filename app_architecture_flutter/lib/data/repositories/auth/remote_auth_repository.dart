// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:app_architecture_flutter/data/services/auth/auth_client_http.dart';
import 'package:app_architecture_flutter/domain/dtos/credentials.dart';
import 'package:app_architecture_flutter/domain/validators/credentials_validator.dart';
import 'package:app_architecture_flutter/utils/validation/lucid_validator_extension.dart';
import 'package:result_dart/result_dart.dart';

import 'package:app_architecture_flutter/data/repositories/auth/auth_repository.dart';
import 'package:app_architecture_flutter/data/services/auth/auth_local_storage.dart';
import 'package:app_architecture_flutter/domain/entities/user_entity.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository(this._authLocalStorage, this._authClientHttp);
  final _streamController = StreamController<User>.broadcast();

  final AuthLocalStorage _authLocalStorage;
  final AuthClientHttp _authClientHttp;

  @override
  AsyncResult<LoggedUser> getUser() {
    return _authLocalStorage.getUser();
  }

  @override
  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final validator = CredentialsValidator();

    return validator 
        .validateResult(credentials)
        .flatMap(_authClientHttp.login)
        .flatMap(_authLocalStorage.saveUser)
        .onSuccess(_streamController.add);
  }

  @override
  AsyncResult<Unit> logout() {
    return _authLocalStorage
        .removeUser()
        .onSuccess((_) => _streamController.add(const NotLoggedUser()));
  }

  @override
  Stream<User> userObserver() {
    return _streamController.stream;
  }

  @override
  void dispose() {
    _streamController.close();
  }
}
