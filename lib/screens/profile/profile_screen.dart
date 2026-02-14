import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/app_provider.dart';
import '../auth/phone_auth_screen.dart' show LoginScreen;

/// User Profile & Settings screen with avatar, activity, preferences, system
/// Matches reference: user_profile_&_settings/screen.png
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final user = provider.currentUser;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 24),

              // Profile avatar with edit button
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 52,
                      backgroundImage: NetworkImage(user.avatarUrl),
                      onBackgroundImageError: (_, __) {},
                      child: user.avatarUrl.isEmpty
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                  ),
                  // Edit button
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(Icons.edit,
                          color: Colors.white, size: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // User name
              Text(
                user.name,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 6),

              // Verified owner badge
              if (user.isVerifiedOwner)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.success.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.verified,
                          color: AppColors.success, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        AppStrings.verifiedOwner,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 28),

              // MY ACTIVITY section
              _buildSectionHeader(AppStrings.myActivity),
              _buildSettingsCard([
                _SettingItem(
                  icon: Icons.calendar_today,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.primary.withOpacity(0.1),
                  title: AppStrings.myBookings,
                  onTap: () {},
                ),
                _SettingItem(
                  icon: Icons.local_parking,
                  iconColor: AppColors.accent,
                  iconBg: AppColors.accent.withOpacity(0.1),
                  title: AppStrings.myParkings,
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 12),

              // PREFERENCES section
              _buildSectionHeader(AppStrings.preferences),
              _buildSettingsCard([
                _SettingItem(
                  icon: Icons.payment,
                  iconColor: AppColors.info,
                  iconBg: AppColors.info.withOpacity(0.1),
                  title: AppStrings.paymentMethods,
                  onTap: () {},
                ),
                _SettingItem(
                  icon: Icons.favorite,
                  iconColor: Colors.pink,
                  iconBg: Colors.pink.withOpacity(0.1),
                  title: AppStrings.favoriteSpots,
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 12),

              // SYSTEM section
              _buildSectionHeader(AppStrings.system),
              _buildSettingsCard([
                _SettingItem(
                  icon: Icons.notifications,
                  iconColor: AppColors.primary,
                  iconBg: AppColors.primary.withOpacity(0.1),
                  title: AppStrings.notifications,
                  trailing: Container(
                    width: 44,
                    height: 26,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  onTap: () {},
                ),
                _SettingItem(
                  icon: Icons.help_outline,
                  iconColor: AppColors.accent,
                  iconBg: AppColors.accent.withOpacity(0.1),
                  title: AppStrings.helpSupport,
                  onTap: () {},
                ),
                _SettingItem(
                  icon: Icons.settings,
                  iconColor: AppColors.textSecondary,
                  iconBg: AppColors.textSecondary.withOpacity(0.1),
                  title: AppStrings.settings,
                  onTap: () {},
                ),
              ]),
              const SizedBox(height: 20),

              // Log Out button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      provider.logout();
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout, color: AppColors.error),
                    label: Text(
                      AppStrings.logOut,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.error,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                          color: AppColors.cardBorder, width: 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // App version
              Text(
                'Smart Park Connect ${AppStrings.appVersion}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: AppColors.textHint,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<_SettingItem> items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return Column(
            children: [
              InkWell(
                onTap: item.onTap,
                borderRadius: BorderRadius.vertical(
                  top: index == 0
                      ? const Radius.circular(16)
                      : Radius.zero,
                  bottom: index == items.length - 1
                      ? const Radius.circular(16)
                      : Radius.zero,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: item.iconBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon,
                            color: item.iconColor, size: 20),
                      ),
                      const SizedBox(width: 14),
                      // Title
                      Expanded(
                        child: Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      // Trailing widget or chevron
                      if (item.trailing != null) ...[
                        item.trailing!,
                        const SizedBox(width: 8),
                      ],
                      const Icon(Icons.chevron_right,
                          color: AppColors.textHint, size: 22),
                    ],
                  ),
                ),
              ),
              if (index < items.length - 1)
                Divider(
                  height: 1,
                  indent: 68,
                  color: AppColors.divider,
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _SettingItem {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final Widget? trailing;
  final VoidCallback onTap;

  const _SettingItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    this.trailing,
    required this.onTap,
  });
}
