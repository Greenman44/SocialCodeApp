import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LanguageDropDown extends StatefulWidget {
  LanguageDropDown(this.selectedValue, this.items, {super.key});
  final List<DropdownMenuItem<String>> items;
  String selectedValue;
  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
        alignment: AlignmentDirectional.centerEnd,
        style: const TextStyle(color: Colors.black),
        dropdownColor: Colors.white,
        isDense: false,
        isExpanded: true,
        icon: const Icon(
          Icons.text_format,
          color: Colors.black,
        ),
        items: widget.items,
        value: widget.selectedValue,
        onChanged: (value) {
          if (value != null) {
            widget.selectedValue = value;
            setState(() {});
          }
        });
  }
}
