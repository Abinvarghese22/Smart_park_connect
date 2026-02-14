import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

/// Admin dashboard screen with stats, user management, parking approvals
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Admin Dashboard',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                      'Total Users', '1,245', Icons.people, AppColors.primary),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Total Spaces', '342',
                      Icons.local_parking, AppColors.accent),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard('Active Bookings', '89',
                      Icons.calendar_today, AppColors.success),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard('Revenue', '\u20B91.2L',
                      Icons.account_balance_wallet, AppColors.starYellow),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Quick Actions
            Text(
              'MANAGEMENT',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textHint,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildActionTile(
              Icons.people_outline,
              'User Management',
              'View and manage all registered users',
              AppColors.primary,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const _UserListScreen()),
              ),
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              Icons.verified_user_outlined,
              'Parking Approvals',
              'Review and approve new parking listings',
              AppColors.warning,
              () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const _ParkingApprovalScreen()),
              ),
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              Icons.analytics_outlined,
              'System Analytics',
              'View platform analytics and reports',
              AppColors.success,
              () {},
            ),
            const SizedBox(height: 10),
            _buildActionTile(
              Icons.report_outlined,
              'Reports & Issues',
              'Handle user reports and complaints',
              AppColors.error,
              () {},
            ),
            const SizedBox(height: 28),

            // Pending Approvals
            Text(
              'PENDING APPROVALS',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textHint,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            _buildApprovalCard(
              'New Parking: Green Valley Spot',
              'Submitted by Rahul Kumar',
              '2 hours ago',
            ),
            const SizedBox(height: 8),
            _buildApprovalCard(
              'New Parking: Metro Station Lot',
              'Submitted by Priya Singh',
              '5 hours ago',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(
      String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 22),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle,
      Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right,
                color: AppColors.textHint, size: 22),
          ],
        ),
      ),
    );
  }

  Widget _buildApprovalCard(
      String title, String subtitle, String timeAgo) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.warning.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.warning.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.pending_actions,
                color: AppColors.warning, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  timeAgo,
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textHint,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right,
              color: AppColors.textHint, size: 22),
        ],
      ),
    );
  }
}

/// User list screen for admin
class _UserListScreen extends StatelessWidget {
  const _UserListScreen();

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'John Doe', 'email': 'john@email.com', 'role': 'Owner', 'status': 'Active'},
      {'name': 'Priya Singh', 'email': 'priya@email.com', 'role': 'Driver', 'status': 'Active'},
      {'name': 'Rahul Kumar', 'email': 'rahul@email.com', 'role': 'Owner', 'status': 'Active'},
      {'name': 'Sneha Reddy', 'email': 'sneha@email.com', 'role': 'Driver', 'status': 'Suspended'},
      {'name': 'Vikram Singh', 'email': 'vikram@email.com', 'role': 'Owner', 'status': 'Active'},
      {'name': 'Anita Sharma', 'email': 'anita@email.com', 'role': 'Driver', 'status': 'Active'},
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'User Management',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          final isActive = user['status'] == 'Active';
          return Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    user['name']![0],
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        user['email']!,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: (user['role'] == 'Owner'
                                ? AppColors.accent
                                : AppColors.info)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        user['role']!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: user['role'] == 'Owner'
                              ? AppColors.accent
                              : AppColors.info,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: (isActive ? AppColors.success : AppColors.error)
                            .withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        user['status']!,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color:
                              isActive ? AppColors.success : AppColors.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Parking approval screen for admin
class _ParkingApprovalScreen extends StatelessWidget {
  const _ParkingApprovalScreen();

  @override
  Widget build(BuildContext context) {
    final pendingSpaces = [
      {
        'name': 'Green Valley Parking',
        'owner': 'Rahul Kumar',
        'address': 'HSR Layout, Bangalore',
        'price': '\u20B945/hr',
        'type': 'Covered',
      },
      {
        'name': 'Metro Station Lot',
        'owner': 'Priya Singh',
        'address': 'Indiranagar Metro, Bangalore',
        'price': '\u20B930/hr',
        'type': 'Open',
      },
      {
        'name': 'Tech Park Basement',
        'owner': 'Amit Patel',
        'address': 'Whitefield, Bangalore',
        'price': '\u20B960/hr',
        'type': 'Underground',
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Parking Approvals',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: pendingSpaces.length,
        itemBuilder: (context, index) {
          final space = pendingSpaces[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image placeholder
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.shimmerBase,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.local_parking,
                        size: 40, color: AppColors.textHint),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        space['name']!,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.warning.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'PENDING',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppColors.warning,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'By ${space['owner']}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Text(
                  space['address']!,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textHint,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildInfoChip(space['price']!),
                    const SizedBox(width: 8),
                    _buildInfoChip(space['type']!),
                  ],
                ),
                const SizedBox(height: 14),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.error,
                          side: const BorderSide(color: AppColors.error),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text('Reject',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.success,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          elevation: 0,
                        ),
                        child: Text('Approve',
                            style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600, fontSize: 14)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}
