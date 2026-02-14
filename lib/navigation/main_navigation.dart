import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../providers/app_provider.dart';
import '../screens/home/home_screen.dart';
import '../screens/home/saved_screen.dart';
import '../screens/booking/bookings_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/owner/owner_dashboard_screen.dart';

/// Main navigation shell with bottom navigation bar
/// Matches reference: 5-tab bottom nav (Explore, Bookings, Host, Messages, Profile)
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  // Screens for each tab
  final List<Widget> _screens = const [
    HomeScreen(),
    SavedScreen(),
    OwnerDashboardScreen(),
    BookingsScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.explore_outlined, Icons.explore,
                    AppStrings.explore),
                _buildNavItem(1, Icons.bookmark_border, Icons.bookmark,
                    AppStrings.bookings),
                _buildHostButton(),
                _buildNavItem(3, Icons.chat_bubble_outline,
                    Icons.chat_bubble, AppStrings.messages),
                _buildNavItem(
                    4, Icons.person_outline, Icons.person, AppStrings.profile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Regular nav item
  Widget _buildNavItem(
      int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColors.primary : AppColors.textHint,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? AppColors.primary : AppColors.textHint,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Center "Host" button with elevated purple circle (matches reference)
  Widget _buildHostButton() {
    final isSelected = _currentIndex == 2;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.4),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
          const SizedBox(height: 4),
          Text(
            AppStrings.host,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? AppColors.primary : AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }
}
