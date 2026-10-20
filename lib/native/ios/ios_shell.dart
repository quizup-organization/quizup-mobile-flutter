import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import 'ios_home_screen.dart';
import 'ios_placeholder_screen.dart';
import 'ios_topics_screen.dart';

class IosShell extends StatelessWidget {
  const IosShell({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  Widget build(BuildContext context) {
    return cupertino.CupertinoTabScaffold(
      tabBar: const cupertino.CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(cupertino.CupertinoIcons.house),
            activeIcon: Icon(cupertino.CupertinoIcons.house_fill),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(cupertino.CupertinoIcons.square_grid_2x2),
            activeIcon: Icon(cupertino.CupertinoIcons.square_grid_2x2),
            label: 'Sujets',
          ),
          BottomNavigationBarItem(
            icon: Icon(cupertino.CupertinoIcons.person_2),
            activeIcon: Icon(cupertino.CupertinoIcons.person_2_fill),
            label: 'Social',
          ),
          BottomNavigationBarItem(
            icon: Icon(cupertino.CupertinoIcons.bell),
            activeIcon: Icon(cupertino.CupertinoIcons.bell_fill),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(cupertino.CupertinoIcons.person_crop_circle),
            activeIcon: Icon(cupertino.CupertinoIcons.person_crop_circle_fill),
            label: 'Profil',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return cupertino.CupertinoTabView(
          builder: (context) {
            return switch (index) {
              0 => IosHomeScreen(fixtures: fixtures),
              1 => IosTopicsScreen(fixtures: fixtures),
              2 => const IosPlaceholderScreen(
                  title: 'Social',
                  icon: cupertino.CupertinoIcons.person_2,
                  message: 'Abonnements, défis et salons.',
                ),
              3 => const IosPlaceholderScreen(
                  title: 'Notifications',
                  icon: cupertino.CupertinoIcons.bell,
                  message: 'Ton inbox et tes préférences.',
                ),
              _ => const IosPlaceholderScreen(
                  title: 'Profil',
                  icon: cupertino.CupertinoIcons.person_crop_circle,
                  message: 'Ta progression et tes réglages.',
                ),
            };
          },
        );
      },
    );
  }
}
