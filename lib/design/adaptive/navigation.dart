import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

class QuizupNavItem {
  const QuizupNavItem({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.cupertinoIcon,
    required this.cupertinoActiveIcon,
    this.badgeCount = 0,
  });

  final String label;
  final IconData icon;
  final IconData activeIcon;
  final IconData cupertinoIcon;
  final IconData cupertinoActiveIcon;
  final int badgeCount;
}

const List<QuizupNavItem> quizupNavItems = [
  QuizupNavItem(
    label: 'Accueil',
    icon: Icons.home_outlined,
    activeIcon: Icons.home_rounded,
    cupertinoIcon: cupertino.CupertinoIcons.house,
    cupertinoActiveIcon: cupertino.CupertinoIcons.house_fill,
  ),
  QuizupNavItem(
    label: 'Sujets',
    icon: Icons.grid_view_outlined,
    activeIcon: Icons.grid_view_rounded,
    cupertinoIcon: cupertino.CupertinoIcons.square_grid_2x2,
    cupertinoActiveIcon: cupertino.CupertinoIcons.square_grid_2x2,
  ),
  QuizupNavItem(
    label: 'Social',
    icon: Icons.people_outline_rounded,
    activeIcon: Icons.people_rounded,
    cupertinoIcon: cupertino.CupertinoIcons.person_2,
    cupertinoActiveIcon: cupertino.CupertinoIcons.person_2_fill,
    badgeCount: 2,
  ),
  QuizupNavItem(
    label: 'Notifications',
    icon: Icons.notifications_none_rounded,
    activeIcon: Icons.notifications_rounded,
    cupertinoIcon: cupertino.CupertinoIcons.bell,
    cupertinoActiveIcon: cupertino.CupertinoIcons.bell_fill,
    badgeCount: 3,
  ),
  QuizupNavItem(
    label: 'Profil',
    icon: Icons.person_outline_rounded,
    activeIcon: Icons.person_rounded,
    cupertinoIcon: cupertino.CupertinoIcons.person_crop_circle,
    cupertinoActiveIcon: cupertino.CupertinoIcons.person_crop_circle_fill,
  ),
];
