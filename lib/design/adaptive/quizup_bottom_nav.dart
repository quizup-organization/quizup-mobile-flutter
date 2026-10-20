import 'dart:ui' as ui;

import 'package:material_ui/material_ui.dart';

import '../components/pressable_scale.dart';
import '../components/quizup_text.dart';
import '../tokens.dart';
import 'navigation.dart';

class QuizupBottomNav extends StatelessWidget {
  const QuizupBottomNav({
    super.key,
    required this.currentIndex,
    required this.onSelected,
    this.items = quizupNavItems,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;
  final List<QuizupNavItem> items;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;

    return SafeArea(
      top: false,
      minimum: const EdgeInsets.only(left: 14, right: 14, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(tokens.radii.xxxxl),
        child: BackdropFilter(
          filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: 64,
            decoration: BoxDecoration(
              color: colors.card.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(tokens.radii.xxxxl),
              border: Border.all(
                color: colors.border.withValues(alpha: 0.9),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.18),
                  blurRadius: 28,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                for (var index = 0; index < items.length; index++)
                  Expanded(
                    child: _BottomNavItem(
                      key: ValueKey('nav-item-$index'),
                      item: items[index],
                      selected: index == currentIndex,
                      onTap: () => onSelected(index),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final QuizupNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final foreground = selected ? colors.primary : colors.mutedForeground;

    return PressableScale(
      onTap: onTap,
      semanticLabel: item.label,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? colors.primary.withValues(alpha: 0.12)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Icon(
                  selected ? item.activeIcon : item.icon,
                  size: 20,
                  color: foreground,
                ),
              ),
              if (item.badgeCount > 0)
                Positioned(
                  top: -3,
                  right: -3,
                  child: Container(
                    width: 15,
                    height: 15,
                    decoration: BoxDecoration(
                      color: colors.destructive,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: colors.card, width: 1.5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      item.badgeCount > 9 ? '9+' : '${item.badgeCount}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 8,
                        height: 1,
                        fontWeight: FontWeight.w700,
                        color: colors.destructiveForeground,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 3),
          QuizupText(
            item.label,
            size: 9.5,
            weight: selected ? FontWeight.w600 : FontWeight.w500,
            color: foreground,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
