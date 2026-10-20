import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../components/pressable_scale.dart';
import '../tokens.dart';

class AdaptiveIconButton extends StatelessWidget {
  const AdaptiveIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.badgeCount = 0,
    this.size = 20,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final int badgeCount;
  final double size;

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    final iconWidget = Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(
          icon,
          size: size,
          color: onPressed == null ? colors.mutedForeground : colors.foreground,
        ),
        if (badgeCount > 0)
          Positioned(
            right: -6,
            top: -5,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: colors.destructive,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                badgeCount > 9 ? '9+' : '$badgeCount',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 9,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                  color: colors.destructiveForeground,
                ),
              ),
            ),
          ),
      ],
    );

    final content = Tooltip(
      message: tooltip ?? '',
      child: SizedBox(
        width: 40,
        height: 40,
        child: Center(child: iconWidget),
      ),
    );

    if (!settings.isPlatformMode) {
      return PressableScale(
        onTap: onPressed,
        semanticLabel: tooltip,
        child: content,
      );
    }

    if (settings.isIOS) {
      return cupertino.CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        minimumSize: const Size(40, 40),
        child: content,
      );
    }

    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      constraints: const BoxConstraints.tightFor(width: 40, height: 40),
      padding: EdgeInsets.zero,
      iconSize: size,
      icon: iconWidget,
    );
  }
}
