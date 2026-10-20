import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../components/quizup_text.dart';
import '../tokens.dart';
import 'adaptive_icon_button.dart';

class QuizupTopBar extends StatelessWidget {
  const QuizupTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.showBack = false,
    this.onBack,
    this.actions = const [],
  });

  final String title;
  final String? subtitle;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final topPadding = MediaQuery.paddingOf(context).top;

    return ClipRect(
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          padding: EdgeInsets.only(top: topPadding, left: 14, right: 14),
          decoration: BoxDecoration(
            color: colors.background.withValues(alpha: 0.82),
            border: Border(
              bottom: BorderSide(
                color: colors.border.withValues(alpha: 0.72),
              ),
            ),
          ),
          child: SizedBox(
            height: 56,
            child: Row(
              children: [
                if (showBack) ...[
                  AdaptiveIconButton(
                    icon: Icons.arrow_back_rounded,
                    tooltip: 'Retour',
                    onPressed:
                        onBack ?? () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 4),
                ] else ...[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          colors.primary,
                          Color.lerp(colors.primary, Colors.black, 0.22) ??
                              colors.primary,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Q',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      QuizupText(
                        title,
                        size: 15,
                        weight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (subtitle != null)
                        QuizupText(
                          subtitle!,
                          size: 10,
                          weight: FontWeight.w500,
                          color: colors.mutedForeground,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Row(mainAxisSize: MainAxisSize.min, children: actions),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
