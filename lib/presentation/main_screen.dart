import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/screens/home_screen.dart';
import 'package:network/presentation/friends/screens/friends_screen.dart';
import 'package:network/presentation/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final AuthProvider authProvider;

  const MainScreen({
    super.key,
    required this.themeProvider,
    required this.authProvider,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeScreen(authProvider: widget.authProvider),
      FriendsScreen(authProvider: widget.authProvider),
      ProfileScreen(
        themeProvider: widget.themeProvider,
        authProvider: widget.authProvider,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          Icon(FIcons.house, color: context.theme.colors.primaryForeground),
          Icon(FIcons.users, color: context.theme.colors.primaryForeground),
          Icon(FIcons.user, color: context.theme.colors.primaryForeground),
        ],
        color: context.theme.colors.primary,
        buttonBackgroundColor: context.theme.colors.primary,
        backgroundColor: context.theme.colors.background,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 350),
      ),
    );
  }
}
