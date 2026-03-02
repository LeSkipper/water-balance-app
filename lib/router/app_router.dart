import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../pages/home_page.dart';
import '../pages/stats_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../theme/app_theme.dart';

GoRouter createRouter(AppProvider provider) {
  return GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final isAuth = provider.isAuthenticated;
      final isAuthPage =
          state.matchedLocation == '/login' || state.matchedLocation == '/register';

      if (!isAuth && !isAuthPage) return '/login';
      if (isAuth && isAuthPage) return '/';
      return null;
    },
    refreshListenable: provider,
    routes: [
      GoRoute(path: '/login', builder: (_, __) => const LoginPage()),
      GoRoute(path: '/register', builder: (_, __) => const RegisterPage()),
      ShellRoute(
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(path: '/', builder: (_, __) => const HomePage()),
          GoRoute(path: '/stats', builder: (_, __) => const StatsPage()),
          GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
          GoRoute(path: '/settings', builder: (_, __) => const SettingsPage()),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;
  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  static const _items = [
    _NavItem(path: '/', icon: Icons.home_rounded, label: 'Home'),
    _NavItem(path: '/stats', icon: Icons.bar_chart_rounded, label: 'Stats'),
    _NavItem(path: '/profile', icon: Icons.person_rounded, label: 'Profile'),
    _NavItem(path: '/settings', icon: Icons.settings_rounded, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final c = AppColorsData.of(context);

    return Container(
      decoration: BoxDecoration(
        color: c.navBarBg.withOpacity(0.95),
        border: Border(
          top: BorderSide(color: c.border),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _items.map((item) {
              final isActive = location == item.path;
              return _NavButton(item: item, isActive: isActive);
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final String path;
  final IconData icon;
  final String label;
  const _NavItem({required this.path, required this.icon, required this.label});
}

class _NavButton extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  const _NavButton({required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final c = AppColorsData.of(context);

    return GestureDetector(
      onTap: () => context.go(item.path),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                gradient: isActive
                    ? const LinearGradient(
                        colors: [Color(0xFF3B82F6), Color(0xFF6366F1)],
                      )
                    : null,
                color: isActive ? null : Colors.transparent,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 4),
            Icon(
              item.icon,
              size: 22,
              color: isActive ? c.primary : c.textFaint,
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                color: isActive ? c.primary : c.textFaint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
