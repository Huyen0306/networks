import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/login/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const LoginScreen({super.key, required this.authProvider});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController(text: 'emilys');
  final _passwordController = TextEditingController(text: 'emilyspass');
  final _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final username = _usernameController.text.trim();
    final password = _passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'Vui lòng nhập đầy đủ thông tin';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _authService.login(
        username: username,
        password: password,
        expiresInMins: 30,
      );

      // Đăng nhập thành công
      final userData = response.data;
      await widget.authProvider.login(userData['email'] ?? username);

      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Đăng nhập thất bại. Vui lòng thử lại.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Stack(
        children: [
          // Background image ở phía dưới
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 30),
              child: Image.asset(
                'assets/images/login.png',
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
          // Nội dung form ở phía trên
          SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 60),
                Text(
                  'LOGIN',
                  style: AppFonts.bbhBartle(fontSize: 48),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 48),
                FTextFormField(
                  controller: _usernameController,
                  label: const Text('Username'),
                  style: (style) => style.copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 18,
                    ),
                  ),
                  hint: 'Nhập username của bạn',
                  textCapitalization: TextCapitalization.none,
                  enabled: !_isLoading,
                  clearable: (value) => value.text.isNotEmpty,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập username';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 16),
                FTextFormField.password(
                  controller: _passwordController,
                  style: (style) => style.copyWith(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 18,
                    ),
                  ),
                  hint: 'Nhập mật khẩu của bạn',
                  enabled: !_isLoading,
                  clearable: (value) => value.text.isNotEmpty,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập mật khẩu';
                    }
                    if (value.length < 6) {
                      return 'Mật khẩu phải có ít nhất 6 ký tự';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                if (_errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: context.theme.colors.destructive,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _errorMessage!,
                      style: AppFonts.inter(
                        color: context.theme.colors.destructiveForeground,
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
                FButton(
                  onPress: _isLoading ? null : _handleLogin,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Đăng nhập'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(height: MediaQuery.of(context).size.height * 0.2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
