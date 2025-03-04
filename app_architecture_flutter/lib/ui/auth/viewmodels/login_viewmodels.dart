import 'package:app_architecture_flutter/data/repositories/auth/auth_repository.dart';
import 'package:app_architecture_flutter/domain/dtos/credentials.dart';
import 'package:flutter/foundation.dart';

class LoginViewmodels extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginViewmodels(this._authRepository);

  Future<void> login(Credentials credentials) async {
    await _authRepository.login(credentials);
  }
}
