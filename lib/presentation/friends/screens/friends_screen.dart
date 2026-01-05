import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:network/core/auth/auth_provider.dart';
import 'package:network/core/models/user_model.dart';
import 'package:network/core/theme/app_fonts.dart';
import 'package:network/presentation/friends/screens/friend_detail_screen.dart';
import 'package:network/presentation/friends/services/friends_service.dart';
import 'package:network/presentation/friends/widgets/friend_card.dart';

class FriendsScreen extends StatefulWidget {
  final AuthProvider authProvider;

  const FriendsScreen({super.key, required this.authProvider});

  @override
  State<FriendsScreen> createState() => _FriendsScreenState();
}

class _FriendsScreenState extends State<FriendsScreen> {
  final _friendsService = FriendsService();
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      scaffoldStyle: (style) => style.copyWith(
        headerDecoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: context.theme.colors.border, width: 0.5),
          ),
        ),
      ),
      header: FHeader(
        title: Text('Friends', style: AppFonts.bbhBartle(fontSize: 40)),
        suffixes: [
          SizedBox(
            width: 220,
            child: FTextFormField(
              controller: _searchController,
              hint: 'Tìm bạn bè...',
              clearable: (value) => value.text.isNotEmpty,
              style: (style) => style.copyWith(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: FutureBuilder(
            future: _searchQuery.isEmpty
                ? _friendsService.getUsers()
                : _friendsService.searchUsers(_searchQuery),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: FProgress(semanticsLabel: 'Loading friends'),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Lỗi: ${snapshot.error}',
                    style: AppFonts.inter(),
                  ),
                );
              }

              if (!snapshot.hasData) {
                return const Center(child: Text('Không có dữ liệu'));
              }

              final response = snapshot.data!;
              final users = response.data['users'] as List;

              if (users.isEmpty) {
                return Center(
                  child: Text(
                    'Không tìm thấy bạn bè nào',
                    style: AppFonts.inter(
                      color: context.theme.colors.mutedForeground,
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                itemCount: users.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final userData = users[index];
                  final user = UserModel.fromJson(userData);
                  return FriendCard(
                    firstName: user.firstName,
                    lastName: user.lastName,
                    imageUrl: user.image,
                    onViewDetail: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FriendDetailScreen(user: user),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
