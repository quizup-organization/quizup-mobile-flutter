import 'package:cupertino_ui/cupertino_ui.dart' as cupertino;
import 'package:material_ui/material_ui.dart';

import '../app_settings.dart';
import '../tokens.dart';
import 'native_style.dart';
import 'navigation.dart';
import 'quizup_bottom_nav.dart';
import 'quizup_top_bar.dart';

class AdaptiveScaffold extends StatefulWidget {
  const AdaptiveScaffold({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.currentIndex = 0,
    this.onTabSelected,
    this.showNav = true,
    this.showBack = false,
    this.onBack,
    this.actions = const [],
  });

  final String title;
  final String? subtitle;
  final Widget body;
  final int currentIndex;
  final ValueChanged<int>? onTabSelected;
  final bool showNav;
  final bool showBack;
  final VoidCallback? onBack;
  final List<Widget> actions;

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}

class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
  bool _navVisible = true;

  bool _onScroll(ScrollNotification notification) {
    if (notification.depth != 0 ||
        notification.metrics.axis != Axis.vertical) {
      return false;
    }
    if (notification is! ScrollUpdateNotification) {
      return false;
    }
    final delta = notification.scrollDelta ?? 0;
    final atTop = notification.metrics.pixels <= 24;
    if (atTop && !_navVisible) {
      setState(() => _navVisible = true);
    } else if (delta > 6 && _navVisible) {
      setState(() => _navVisible = false);
    } else if (delta < -6 && !_navVisible) {
      setState(() => _navVisible = true);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettingsScope.of(context);
    if (!settings.isPlatformMode) {
      return _buildQuizup(context);
    }
    if (settings.isIOS) {
      return _buildIOS(context);
    }
    return _buildAndroid(context);
  }

  Widget _buildQuizup(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final onTab = widget.onTabSelected ?? (_) {};
    final navSpace = 64 + MediaQuery.paddingOf(context).bottom + 10;

    return Scaffold(
      backgroundColor: colors.background,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Column(
            children: [
              QuizupTopBar(
                title: widget.title,
                subtitle: widget.subtitle,
                showBack: widget.showBack,
                onBack: widget.onBack,
                actions: widget.actions,
              ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: _onScroll,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: widget.showNav ? navSpace : 0,
                    ),
                    child: widget.body,
                  ),
                ),
              ),
            ],
          ),
          if (widget.showNav)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: AnimatedSlide(
                offset: _navVisible ? Offset.zero : const Offset(0, 1.25),
                duration: const Duration(milliseconds: 220),
                curve: Curves.easeOutCubic,
                child: QuizupBottomNav(
                  currentIndex: widget.currentIndex,
                  onSelected: onTab,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIOS(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final onTab = widget.onTabSelected ?? (_) {};

    return Scaffold(
      backgroundColor: colors.background,
      appBar: cupertino.CupertinoNavigationBar(
        middle: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: nativeTextStyle(
            platform: TargetPlatform.iOS,
            size: 17,
            weight: FontWeight.w600,
            color: colors.foreground,
          ),
        ),
        leading: widget.showBack
            ? cupertino.CupertinoButton(
                padding: EdgeInsets.zero,
                minSize: const Size(40, 40),
                onPressed: widget.onBack ??
                    () => Navigator.of(context).maybePop(),
                child: Icon(
                  cupertino.CupertinoIcons.back,
                  color: colors.foreground,
                ),
              )
            : null,
        trailing: widget.actions.isEmpty
            ? null
            : Row(mainAxisSize: MainAxisSize.min, children: widget.actions),
        backgroundColor: colors.background.withValues(alpha: 0.92),
        border: Border(
          bottom: BorderSide(color: colors.border, width: 0.5),
        ),
      ),
      bottomNavigationBar: widget.showNav
          ? cupertino.CupertinoTabBar(
              items: [
                for (final item in quizupNavItems)
                  BottomNavigationBarItem(
                    icon: Icon(item.cupertinoIcon),
                    activeIcon: Icon(item.cupertinoActiveIcon),
                    label: item.label,
                  ),
              ],
              currentIndex: widget.currentIndex,
              onTap: onTab,
              backgroundColor: colors.card,
              activeColor: colors.primary,
              inactiveColor: colors.mutedForeground,
              border: Border(
                top: BorderSide(color: colors.border, width: 0.5),
              ),
            )
          : null,
      body: SafeArea(top: false, child: widget.body),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    final tokens = QuizupTheme.of(context);
    final colors = tokens.colors;
    final onTab = widget.onTabSelected ?? (_) {};

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: nativeTextStyle(
            platform: TargetPlatform.android,
            size: 20,
            weight: FontWeight.w600,
            color: colors.foreground,
          ),
        ),
        leading: widget.showBack
            ? BackButton(
                onPressed: widget.onBack,
                color: colors.foreground,
              )
            : null,
        actions: widget.actions,
        backgroundColor: colors.background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: widget.showNav
          ? Theme(
              data: Theme.of(context).copyWith(
                navigationBarTheme: NavigationBarThemeData(
                  backgroundColor: colors.card,
                  surfaceTintColor: Colors.transparent,
                  indicatorColor: colors.primary.withValues(alpha: 0.14),
                  labelTextStyle: WidgetStatePropertyAll<TextStyle>(
                    nativeTextStyle(
                      platform: TargetPlatform.android,
                      size: 11,
                      weight: FontWeight.w500,
                      color: colors.foreground,
                    ),
                  ),
                  iconTheme: WidgetStatePropertyAll<IconThemeData>(
                    IconThemeData(color: colors.foreground),
                  ),
                ),
              ),
              child: NavigationBar(
                selectedIndex: widget.currentIndex,
                onDestinationSelected: onTab,
                destinations: [
                  for (final item in quizupNavItems)
                    NavigationDestination(
                      icon: Icon(item.icon),
                      selectedIcon: Icon(item.activeIcon),
                      label: item.label,
                    ),
                ],
              ),
            )
          : null,
      body: widget.body,
    );
  }
}
