import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/presentation/home/screens/home_screen.dart';
import 'package:network/presentation/friends/screens/friends_screen.dart';
import 'package:network/presentation/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeProvider themeProvider;

  const MainScreen({super.key, required this.themeProvider});

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
      const HomeScreen(),
      const FriendsScreen(),
      ProfileScreen(themeProvider: widget.themeProvider),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: FBottomNavigationBar(
        index: _currentIndex,
        onChange: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        style: (style) => style.copyWith(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: context.theme.colors.border, width: 0.5),
            ),
          ),
        ),
        children: [
          FBottomNavigationBarItem(
            icon: const Icon(FIcons.house),
            label: const Text('Home'),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FIcons.users),
            label: const Text('Friends'),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FIcons.user),
            label: const Text('Profile'),
          ),
        ],
      ),
    );
  }
}
