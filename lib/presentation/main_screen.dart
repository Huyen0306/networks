import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/posts/post_provider.dart';
import 'package:network/core/theme/theme_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/home/screens/home_screen.dart';
import 'package:network/presentation/friends/screens/friends_screen.dart';
import 'package:network/presentation/profile/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeProvider themeProvider;
  final AuthProvider authProvider;
  final PostProvider postProvider;

  const MainScreen({
    super.key,
    required this.themeProvider,
    required this.authProvider,
    required this.postProvider,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;
  late final ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(
      duration: const Duration(seconds: 2),
    );
    _pages = [
      HomeScreen(
        authProvider: widget.authProvider,
        postProvider: widget.postProvider,
      ),
      FriendsScreen(authProvider: widget.authProvider),
      ProfileScreen(
        themeProvider: widget.themeProvider,
        authProvider: widget.authProvider,
      ),
    ];

    if (widget.authProvider.consumeLoginConfetti()) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _confettiController.play();
      });
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(index: _currentIndex, children: _pages),
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              emissionFrequency: 0.05,
              numberOfParticles: 30,
              gravity: 0.2,
              colors: const [
                Color(0xFF4FC3F7),
                Color(0xFF81C784),
                Color(0xFFFFF176),
                Color(0xFFFF8A65),
                Color(0xFFBA68C8),
              ],
            ),
          ),
        ],
      ),
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
            label: Text('Home', style: AppFonts.bbhBartle(fontSize: 12)),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FIcons.users),
            label: Text('Friends', style: AppFonts.bbhBartle(fontSize: 12)),
          ),
          FBottomNavigationBarItem(
            icon: const Icon(FIcons.user),
            label: Text('Profile', style: AppFonts.bbhBartle(fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
