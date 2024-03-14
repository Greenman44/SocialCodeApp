import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  const SignInButton(
      {super.key,
      required this.email,
      required this.password,
      required this.text,
      required this.func});
  final TextEditingController email;
  final TextEditingController password;
  final Widget text;
  final void Function()? func;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (func != null) {
          func!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Theme.of(context).focusColor,
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: text,
        ),
      ),
    );
  }
}
