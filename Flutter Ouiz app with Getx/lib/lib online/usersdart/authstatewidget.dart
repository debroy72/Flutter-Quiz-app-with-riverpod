import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/QuizSelectionScreen.dart';
import 'package:myapp/lib%20online/usersdart/Authprovider.dart';
// Make sure the path matches your project structure
import 'package:myapp/lib%20online/usersdart/loginpage.dart';
// Adjust the import path as needed

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    // If user is not null (i.e., logged in), navigate to QuizSelectionScreen
    // Otherwise, show the LoginScreen
    return user != null ? const QuizSelectionScreen() : const LoginPage();
  }
}
