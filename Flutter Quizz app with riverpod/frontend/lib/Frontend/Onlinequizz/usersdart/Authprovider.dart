import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/AuthenticationStateNotifier.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/Authservice.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/usermodel.dart';

final authStateProvider = StateNotifierProvider<AuthState, User?>((ref) {
  return AuthState(AuthService());
});
