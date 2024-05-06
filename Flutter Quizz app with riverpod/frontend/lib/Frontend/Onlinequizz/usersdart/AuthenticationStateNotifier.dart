import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/Authservice.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/usermodel.dart';

class AuthState extends StateNotifier<User?> {
  final AuthService _authService;

  AuthState(this._authService) : super(null);

  Future<void> login(String username, String password) async {
    final user = await _authService.login(username, password);
    state = user;
  }

  void logout() {
    _authService.logout();
    state = null;
  }
}
