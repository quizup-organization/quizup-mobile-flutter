import 'package:material_ui/material_ui.dart';

String nativeFontFamily(TargetPlatform platform) {
  return platform == TargetPlatform.iOS ? '.SF Pro Text' : 'Roboto';
}

TextStyle nativeTextStyle({
  required TargetPlatform platform,
  double size = 14,
  FontWeight weight = FontWeight.w500,
  Color? color,
}) {
  return TextStyle(
    fontFamily: nativeFontFamily(platform),
    fontSize: size,
    fontWeight: weight,
    color: color,
  );
}
