// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  PasswordTextField(
      {super.key, required this.password, required this.hintText});
  final TextEditingController password;
  final String hintText;
  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordShow = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.password,
      obscureText: passwordShow,
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.security_rounded),
          hintText: widget.hintText,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white)),
          suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  passwordShow = !passwordShow;
                });
              },
              icon: passwordShow
                  ? const Icon(Icons.visibility)
                  : const Icon(Icons.visibility_off))),
    );
  }
}
