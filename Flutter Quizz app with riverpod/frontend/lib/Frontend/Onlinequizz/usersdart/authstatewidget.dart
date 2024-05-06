import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/Frontend/Offlinequizz/QuizSelectionScreen.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/Authprovider.dart';
import 'package:frontend/Frontend/Onlinequizz/usersdart/loginpage.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    return user != null ? const QuizSelectionScreen() : const LoginPage();
  }
}
