import 'package:flutter/material.dart';

class EmailTextField extends StatefulWidget {
  const EmailTextField({super.key, required this.email});
  final TextEditingController email;
  @override
  State<EmailTextField> createState() => _EmailTextFieldState();
}

class _EmailTextFieldState extends State<EmailTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.email,
      decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          hintText: "Email",
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
    );
  }
}
