import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/lib%20online/usersdart/AuthenticationStateNotifier.dart';
import 'package:myapp/lib%20online/usersdart/Authservice.dart';
import 'package:myapp/lib%20online/usersdart/usermodel.dart';

final authStateProvider = StateNotifierProvider<AuthState, User?>((ref) {
  return AuthState(AuthService());
});
