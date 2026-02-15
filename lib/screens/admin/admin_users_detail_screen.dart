import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/app_provider.dart';
import '../../models/user_model.dart';
import '../../services/local_storage_service.dart';

/// Detailed users screen showing all users with filtering and management options
class AdminUsersDetailScreen extends StatefulWidget {
  const AdminUsersDetailScreen({super.key});

  @override
  State<AdminUsersDetailScreen> createState() => _AdminUsersDetailScreenState();
}

class _AdminUsersDetailScreenState extends State<AdminUsersDetailScreen> {
  String _selectedFilter = 'All';
  final List<String> _filterOptions = ['All', 'Admins', 'Owners', 'Users'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final allUsers = provider.allUsers;
    
    // Filter users based on selected filter
    final filteredUsers = _getFilteredUsers(allUsers);

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
          'Total Users (${allUsers.length})',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Filter tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: Row(
              children: _filterOptions.map((filter) {
                final isSelected = _selectedFilter == filter;
                final count = _getFilterCount(allUsers, filter);
                return Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedFilter = filter),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary : AppColors.backgroundLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          Text(
                            '$count',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: isSelected ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            filter,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: isSelected ? Colors.white : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          
          // Users list
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.people_outline,
                          size: 64,
                          color: AppColors.textHint.withOpacity(0.5),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No ${_selectedFilter.toLowerCase()} found',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return _buildUserCard(user);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  List<UserModel> _getFilteredUsers(List<UserModel> users) {
    switch (_selectedFilter) {
      case 'Admins':
        return users.where((u) => u.role == UserRole.admin).toList();
      case 'Owners':
        return users.where((u) => u.role == UserRole.owner).toList();
      case 'Users':
        return users.where((u) => u.role == UserRole.user).toList();
      default:
        return users;
    }
  }

  int _getFilterCount(List<UserModel> users, String filter) {
    switch (filter) {
      case 'Admins':
        return users.where((u) => u.role == UserRole.admin).length;
      case 'Owners':
        return users.where((u) => u.role == UserRole.owner).length;
      case 'Users':
        return users.where((u) => u.role == UserRole.user).length;
      default:
        return users.length;
    }
  }

  Widget _buildUserCard(UserModel user) {
    final roleLabel = _getRoleLabel(user.role);
    final roleColor = _getRoleColor(user.role);
    final statusColor = _getStatusColor(user);
    final statusLabel = _getStatusLabel(user);

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
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: roleColor.withOpacity(0.1),
                child: Text(
                  user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color: roleColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      user.email,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    if (user.phone.isNotEmpty)
                      Text(
                        user.phone,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textHint,
                        ),
                      ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: roleColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      roleLabel,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: roleColor,
                      ),
                    ),
                  ),
                  if (user.role == UserRole.owner) ...[
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        statusLabel,
                        style: GoogleFonts.poppins(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: statusColor,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          
          // User stats
          Row(
            children: [
              _buildStatChip(Icons.calendar_today, '${user.totalBookings} Bookings'),
              const SizedBox(width: 8),
              if (user.role == UserRole.owner) ...[
                _buildStatChip(Icons.local_parking, '${user.totalParkings} Spots'),
                const SizedBox(width: 8),
                _buildStatChip(Icons.account_balance_wallet, '₹${user.earnings.toStringAsFixed(0)}'),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: AppColors.textHint),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.owner:
        return 'Owner';
      case UserRole.user:
        return 'Driver';
    }
  }

  Color _getRoleColor(UserRole role) {
    switch (role) {
      case UserRole.admin:
        return AppColors.error;
      case UserRole.owner:
        return AppColors.accent;
      case UserRole.user:
        return AppColors.info;
    }
  }

  Color _getStatusColor(UserModel user) {
    if (user.role != UserRole.owner) return AppColors.success;
    switch (user.approvalStatus) {
      case ApprovalStatus.approved:
        return AppColors.success;
      case ApprovalStatus.pending:
        return AppColors.warning;
      case ApprovalStatus.rejected:
        return AppColors.error;
    }
  }

  String _getStatusLabel(UserModel user) {
    if (user.role != UserRole.owner) return 'ACTIVE';
    switch (user.approvalStatus) {
      case ApprovalStatus.approved:
        return 'APPROVED';
      case ApprovalStatus.pending:
        return 'PENDING';
      case ApprovalStatus.rejected:
        return 'REJECTED';
    }
  }
}
