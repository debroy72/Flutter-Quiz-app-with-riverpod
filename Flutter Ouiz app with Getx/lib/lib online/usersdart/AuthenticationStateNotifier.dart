import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/usersdart/Authservice.dart';
import 'package:myapp/lib%20online/usersdart/usermodel.dart';

class AuthState extends StateNotifier<User?> {
  final AuthService _authService;

  AuthState(this._authService) : super(null);

  Future<void> login(String username, String password) async {
    final user = await _authService.login(username, password);
    state = user; // Update state with user on successful login
  }

  void logout() {
    _authService.logout();
    state = null; // Clear state on logout
  }
}
