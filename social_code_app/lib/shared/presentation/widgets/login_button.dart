import 'package:flutter/material.dart';
import 'package:social_code_app/config/routes/routes.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => routes["/login"]!,
              settings: const RouteSettings(name: "/login")));
        },
        icon: const Icon(Icons.login));
  }
}
