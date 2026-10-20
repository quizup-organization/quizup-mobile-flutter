import 'package:material_ui/material_ui.dart';

class QuizupAvatar extends StatelessWidget {
  const QuizupAvatar({
    super.key,
    required this.name,
    required this.color,
    this.size = 40,
    this.borderColor,
    this.showBorder = false,
  });

  final String name;
  final Color color;
  final double size;
  final Color? borderColor;
  final bool showBorder;

  String get _initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts.first.isEmpty) {
      return '?';
    }
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            color,
            Color.lerp(color, Colors.black, 0.22) ?? color,
          ],
        ),
        border: showBorder
            ? Border.all(color: borderColor ?? Colors.white, width: 2)
            : null,
      ),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: size * 0.36,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
