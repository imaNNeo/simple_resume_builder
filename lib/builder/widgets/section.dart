part of '../resume_generator.dart';

class Section extends pw.StatelessWidget {
  final String title;
  final List<pw.Widget> children;
  final pw.TextStyle textStyle;

  Section({
    required this.title,
    required this.children,
    pw.TextStyle? textStyle,
  }) : textStyle = textStyle ??
      pw.TextStyle(
        fontSize: 14,
        fontWeight: pw.FontWeight.bold,
      );

  @override
  pw.Widget build(pw.Context context) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(title, style: textStyle),
        pw.SizedBox(height: 4),
        ...children,
      ],
    );
  }
}