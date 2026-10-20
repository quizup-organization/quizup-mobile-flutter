import 'package:material_ui/material_ui.dart';

import '../../data/models.dart';
import 'android_home_screen.dart';
import 'android_placeholder_screen.dart';
import 'android_topics_screen.dart';

class AndroidShell extends StatefulWidget {
  const AndroidShell({super.key, required this.fixtures});

  final QuizupFixtures fixtures;

  @override
  State<AndroidShell> createState() => _AndroidShellState();
}

class _AndroidShellState extends State<AndroidShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          AndroidHomeScreen(fixtures: widget.fixtures),
          AndroidTopicsScreen(fixtures: widget.fixtures),
          const AndroidPlaceholderScreen(
            title: 'Social',
            icon: Icons.people_outline,
            message: 'Abonnements, défis et salons.',
          ),
          const AndroidPlaceholderScreen(
            title: 'Notifications',
            icon: Icons.notifications_none,
            message: 'Ton inbox et tes préférences.',
          ),
          const AndroidPlaceholderScreen(
            title: 'Profil',
            icon: Icons.person_outline,
            message: 'Ta progression et tes réglages.',
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (index) => setState(() => _index = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Icon(Icons.grid_view_outlined),
            selectedIcon: Icon(Icons.grid_view),
            label: 'Sujets',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Social',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
