import 'package:material_ui/material_ui.dart';

import '../tokens.dart';

class QuizupText extends StatelessWidget {
  const QuizupText(
    this.text, {
    super.key,
    this.size = 14,
    this.weight = FontWeight.w400,
    this.color,
    this.height,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign,
    this.letterSpacing,
  });

  final String text;
  final double size;
  final FontWeight weight;
  final Color? color;
  final double? height;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign? textAlign;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: size,
        fontWeight: weight,
        color: color ?? tokens.colors.foreground,
        height: height,
        letterSpacing: letterSpacing,
      ),
    );
  }
}
