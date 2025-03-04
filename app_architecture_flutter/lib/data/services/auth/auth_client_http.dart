import 'package:app_architecture_flutter/core/client_http/client_http.dart';
import 'package:app_architecture_flutter/domain/dtos/credentials.dart';
import 'package:app_architecture_flutter/domain/entities/user_entity.dart';
import 'package:result_dart/result_dart.dart';

class AuthClientHttp {
  final ClientHttp _clientHttp;

  AuthClientHttp(this._clientHttp);

  AsyncResult<LoggedUser> login(Credentials credentials) async {
    final response = await _clientHttp.post('/login', {
      'email': credentials.email,
      'password': credentials.password,
    });

    return response.map((response) {
      return LoggedUser.fromJson(response.data);
    });
  }
}
