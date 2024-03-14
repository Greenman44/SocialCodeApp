import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextEditor extends TextEditingController {
  String currentLanguage = "text";
  List<CodeChunk> chunks = [];
  int previousLength = 0;
  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    List<TextSpan> pieces = [];

    if (chunks.isEmpty && text.length == 1) {
      chunks.add(CodeChunk(0, null, currentLanguage));
    } else {
      if (text.length > previousLength && chunks.last.text == currentLanguage) {
        previousLength = text.length;
      } else if (text.length < previousLength) {
        if (chunks.last.start >= text.length) {
          chunks.removeAt(chunks.length - 1);
        } else if (chunks.last.end != null &&
            chunks.last.start >= chunks.last.end!) {
          chunks.removeAt(chunks.length - 1);
        }
        previousLength = text.length;
      }
      if (chunks.isNotEmpty && chunks.last.text != currentLanguage) {
        chunks.last.end = text.length;
        chunks.add(CodeChunk(text.length, null, currentLanguage));
      }
    }
    for (var chunk in chunks) {
      var min = chunk.start;
      var max = chunk.end ?? text.length;
      if (min >= text.length) {
        continue;
      }
      var str = text.characters.getRange(min, max).string;
      var style = const TextStyle(color: Colors.white);
      if (chunk.text != "text") {
        style = GoogleFonts.truculenta(color: Colors.teal);
      }

      pieces.add(TextSpan(text: str, style: style));
    }
    return TextSpan(children: pieces);
  }

  @override
  void clear() {
    chunks = [];
    currentLanguage = "text";
    previousLength = 0;
    super.clear();
  }
}

class CodeChunk {
  String text;
  int start;
  int? end;
  CodeChunk(this.start, this.end, this.text);
}
