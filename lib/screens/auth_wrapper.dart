import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:news_app/screens/login_register_screen.dart';
import 'package:news_app/main.dart';

/// AuthWrapper decides which screen to show based on auth state.
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);

    // If user is null, show the login/register screen
    if (user == null) {
      return const LoginRegisterScreen();
    }

    // If user exists, show the main app with bottom navigation
    return const MainScreen();
  }
}
