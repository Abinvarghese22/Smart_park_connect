import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/app_provider.dart';
import '../../models/user_model.dart';
import '../../services/local_storage_service.dart';
import 'admin_users_detail_screen.dart';
import 'admin_spaces_detail_screen.dart';
import 'admin_bookings_detail_screen.dart';
import 'admin_revenue_detail_screen.dart';

/// Admin dashboard screen with stats, user management, owner approvals
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Title ──
              Center(
                child: Text('Admin Dashboard',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary)),
              ),
              const SizedBox(height: 24),

              // ── Stat Cards Grid ──
              Row(children: [
                Expanded(
                    child: _statCard(
                        context,
                        'Users',
                        'Manage',
                        Icons.people_alt_outlined,
                        AppColors.primary,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminUsersDetailScreen())))),
                const SizedBox(width: 12),
                Expanded(
                    child: _statCard(
                        context,
                        'Spaces',
                        'Manage',
                        Icons.local_parking_outlined,
                        AppColors.accent,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminSpacesDetailScreen())))),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                    child: _statCard(
                        context,
                        'Bookings',
                        'View All',
                        Icons.calendar_today_outlined,
                        AppColors.success,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminBookingsDetailScreen())))),
                const SizedBox(width: 12),
                Expanded(
                    child: _statCard(
                        context,
                        'Revenue',
                        'Analytics',
                        Icons.account_balance_wallet_outlined,
                        AppColors.starYellow,
                        () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const AdminRevenueDetailScreen())))),
              ]),
              const SizedBox(height: 28),

              // ── Management Section ──
              Text('MANAGEMENT',
                  style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textHint,
                      letterSpacing: 1.2)),
              const SizedBox(height: 12),
              _mgmtTile(
                  context,
                  Icons.people_alt_outlined,
                  'User Management',
                  'View and manage all registered users',
                  AppColors.primary,
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const _UserListScreen()))),
              const SizedBox(height: 10),
              _mgmtTile(
                  context,
                  Icons.business_center_outlined,
                  'Owner Approvals',
                  'Review and approve new owner registrations',
                  AppColors.accent,
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const _OwnerApprovalScreen()))),
              const SizedBox(height: 10),
              _mgmtTile(
                  context,
                  Icons.calendar_month_outlined,
                  'All Bookings',
                  'View all platform bookings with detailed admin oversight',
                  AppColors.success,
                  () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const AdminBookingsDetailScreen()))),
            ],
          ),
        ),
      ),
    );
  }

  // ── Stat Card ──
  Widget _statCard(BuildContext context, String label, String value,
      IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    color.withValues(alpha: 0.15),
                    color.withValues(alpha: 0.06)
                  ]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 22),
              ),
              Icon(Icons.arrow_forward_ios_rounded,
                  size: 14, color: AppColors.textHint.withValues(alpha: 0.5)),
            ]),
            const SizedBox(height: 14),
            Text(value,
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    height: 1)),
            const SizedBox(height: 4),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  // ── Management Tile ──
  Widget _mgmtTile(BuildContext context, IconData icon, String title,
      String subtitle, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 3))
          ],
        ),
        child: Row(children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                color.withValues(alpha: 0.15),
                color.withValues(alpha: 0.06)
              ]),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(title,
                    style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary)),
                Text(subtitle,
                    style: GoogleFonts.poppins(
                        fontSize: 12, color: AppColors.textSecondary)),
              ])),
          Icon(Icons.arrow_forward_ios_rounded,
              size: 16, color: AppColors.textHint.withValues(alpha: 0.4)),
        ]),
      ),
    );
  }
}

/// User list screen for admin - dynamic
class _UserListScreen extends StatelessWidget {
  const _UserListScreen();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final users = provider.allUsers;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xFF5B4CFF), Color(0xFF7C3AED)])),
                child: SafeArea(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${users.length}',
                            style: GoogleFonts.poppins(
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1)),
                        const SizedBox(height: 4),
                        Text('Registered Users',
                            style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white.withValues(alpha: 0.85))),
                      ]),
                )),
              ),
            ),
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(20),
                child: Container(
                    height: 20,
                    decoration: const BoxDecoration(
                        color: Color(0xFFF8F9FE),
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24))))),
          ),
          users.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                      Container(
                          width: 64,
                          height: 64,
                          decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              shape: BoxShape.circle),
                          child: Icon(Icons.people_outline,
                              size: 32,
                              color: AppColors.primary.withValues(alpha: 0.4))),
                      const SizedBox(height: 12),
                      Text('No users found',
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textSecondary)),
                    ])))
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((_, i) {
                    final user = users[i];
                    final rc = user.role == UserRole.owner
                        ? AppColors.accent
                        : user.role == UserRole.admin
                            ? AppColors.error
                            : AppColors.info;
                    final rl = user.role == UserRole.owner
                        ? 'Owner'
                        : user.role == UserRole.admin
                            ? 'Admin'
                            : 'Driver';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black.withValues(alpha: 0.04),
                                blurRadius: 12,
                                offset: const Offset(0, 4))
                          ]),
                      child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(children: [
                            Container(
                              padding: const EdgeInsets.all(2.5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                      colors: [rc, rc.withValues(alpha: 0.4)])),
                              child: CircleAvatar(
                                  radius: 22,
                                  backgroundColor: Colors.white,
                                  backgroundImage: _getAvatarImage(user),
                                  onBackgroundImageError:
                                      _getAvatarImage(user) != null
                                          ? (_, __) {}
                                          : null,
                                  child: _getAvatarImage(user) == null
                                      ? Text(
                                          user.name.isNotEmpty
                                              ? user.name[0].toUpperCase()
                                              : '?',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              color: rc,
                                              fontSize: 16))
                                      : null),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                  Text(user.name,
                                      style: GoogleFonts.poppins(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary)),
                                  Text(user.email,
                                      style: GoogleFonts.poppins(
                                          fontSize: 12,
                                          color: AppColors.textSecondary)),
                                  if (user.phone.isNotEmpty)
                                    Text(user.phone,
                                        style: GoogleFonts.poppins(
                                            fontSize: 11,
                                            color: AppColors.textHint)),
                                ])),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                    rc.withValues(alpha: 0.15),
                                    rc.withValues(alpha: 0.08)
                                  ]),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text(rl,
                                  style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: rc)),
                            ),
                          ])),
                    );
                  }, childCount: users.length)),
                ),
        ],
      ),
    );
  }

  ImageProvider? _getAvatarImage(UserModel user) {
    if (user.avatarUrl.isEmpty) return null;
    if (user.avatarUrl.startsWith('/') || user.avatarUrl.startsWith('C:')) {
      final file = File(user.avatarUrl);
      if (file.existsSync()) return FileImage(file);
      return null;
    }
    return NetworkImage(user.avatarUrl);
  }
}

/// Owner approval screen for admin - manage pending owner registrations
class _OwnerApprovalScreen extends StatelessWidget {
  const _OwnerApprovalScreen();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: LocalStorageService.getPendingOwnerApprovals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: AppColors.backgroundLight,
              body: const Center(
                  child: CircularProgressIndicator(color: AppColors.accent)));
        }
        final pendingOwners = snapshot.data ?? [];

        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 140,
                pinned: true,
                backgroundColor: AppColors.accent,
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context)),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF7C3AED), Color(0xFF5B4CFF)])),
                    child: SafeArea(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${pendingOwners.length}',
                                style: GoogleFonts.poppins(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                    height: 1)),
                            const SizedBox(height: 4),
                            Text('Pending Owner Approvals',
                                style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        Colors.white.withValues(alpha: 0.85))),
                          ]),
                    )),
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(20),
                    child: Container(
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Color(0xFFF8F9FE),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(24))))),
              ),
              pendingOwners.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                          Container(
                              width: 72,
                              height: 72,
                              decoration: BoxDecoration(
                                  color:
                                      AppColors.success.withValues(alpha: 0.08),
                                  shape: BoxShape.circle),
                              child: Icon(Icons.check_circle_outline,
                                  size: 36,
                                  color: AppColors.success
                                      .withValues(alpha: 0.5))),
                          const SizedBox(height: 14),
                          Text('All caught up!',
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary)),
                          const SizedBox(height: 4),
                          Text('No pending owner approvals',
                              style: GoogleFonts.poppins(
                                  fontSize: 13, color: AppColors.textHint)),
                        ])))
                  : SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate((_, i) {
                        final owner = pendingOwners[i];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.04),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4))
                              ]),
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Container(
                                        padding: const EdgeInsets.all(2.5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            gradient: LinearGradient(colors: [
                                              AppColors.accent,
                                              AppColors.accent
                                                  .withValues(alpha: 0.4)
                                            ])),
                                        child: CircleAvatar(
                                            radius: 26,
                                            backgroundColor: Colors.white,
                                            child: Text(
                                                owner.name.isNotEmpty
                                                    ? owner.name[0]
                                                        .toUpperCase()
                                                    : 'O',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.accent,
                                                    fontSize: 20))),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                            Text(owner.name,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    color:
                                                        AppColors.textPrimary)),
                                            Text(owner.email,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: AppColors
                                                        .textSecondary)),
                                            if (owner.phone.isNotEmpty)
                                              Text(owner.phone,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 11,
                                                      color:
                                                          AppColors.textHint)),
                                          ])),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                            color: AppColors.warning
                                                .withValues(alpha: 0.1),
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            border: Border.all(
                                                color: AppColors.warning
                                                    .withValues(alpha: 0.3),
                                                width: 0.5)),
                                        child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                  width: 6,
                                                  height: 6,
                                                  decoration: BoxDecoration(
                                                      color: AppColors.warning,
                                                      shape: BoxShape.circle)),
                                              const SizedBox(width: 5),
                                              Text('Pending',
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          AppColors.warning)),
                                            ]),
                                      ),
                                    ]),
                                    const SizedBox(height: 16),
                                    Row(children: [
                                      Expanded(
                                          child: OutlinedButton.icon(
                                              onPressed: () async {
                                                final error =
                                                    await LocalStorageService
                                                        .rejectOwner(owner.id);
                                                if (context.mounted) {
                                                  if (error != null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content:
                                                                Text(error),
                                                            backgroundColor:
                                                                AppColors
                                                                    .error));
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                '${owner.name} rejected'),
                                                            backgroundColor:
                                                                AppColors.error,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating));
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const _OwnerApprovalScreen()));
                                                  }
                                                }
                                              },
                                              icon: const Icon(Icons.close,
                                                  size: 16),
                                              label: Text('Reject',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13)),
                                              style: OutlinedButton.styleFrom(
                                                  foregroundColor:
                                                      AppColors.error,
                                                  side: const BorderSide(
                                                      color: AppColors.error),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 12)))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                          child: ElevatedButton.icon(
                                              onPressed: () async {
                                                final error =
                                                    await LocalStorageService
                                                        .approveOwner(owner.id);
                                                if (context.mounted) {
                                                  if (error != null) {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(SnackBar(
                                                            content:
                                                                Text(error),
                                                            backgroundColor:
                                                                AppColors
                                                                    .error));
                                                  } else {
                                                    ScaffoldMessenger
                                                            .of(context)
                                                        .showSnackBar(SnackBar(
                                                            content: Text(
                                                                '${owner.name} approved!'),
                                                            backgroundColor:
                                                                AppColors
                                                                    .success,
                                                            behavior:
                                                                SnackBarBehavior
                                                                    .floating));
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const _OwnerApprovalScreen()));
                                                  }
                                                }
                                              },
                                              icon: const Icon(Icons.check,
                                                  size: 16),
                                              label: Text('Approve',
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 13)),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.success,
                                                  foregroundColor: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 12),
                                                  elevation: 0))),
                                    ]),
                                  ])),
                        );
                      }, childCount: pendingOwners.length)),
                    ),
            ],
          ),
        );
      },
    );
  }
}
