import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../providers/app_provider.dart';
import '../../models/booking.dart';

/// Detailed revenue screen showing financial analytics and revenue breakdown
class AdminRevenueDetailScreen extends StatefulWidget {
  const AdminRevenueDetailScreen({super.key});

  @override
  State<AdminRevenueDetailScreen> createState() => _AdminRevenueDetailScreenState();
}

class _AdminRevenueDetailScreenState extends State<AdminRevenueDetailScreen> {
  String _selectedPeriod = 'All Time';
  final List<String> _periodOptions = ['All Time', 'This Month', 'Last Month', 'This Year'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final allBookings = provider.allBookings;
    final completedBookings = allBookings.where((b) => b.status == 'completed').toList();
    
    // Calculate revenue metrics
    final totalRevenue = _calculateTotalRevenue(completedBookings);
    final averageBookingValue = completedBookings.isNotEmpty 
        ? totalRevenue / completedBookings.length 
        : 0.0;
    final monthlyRevenue = _calculateMonthlyRevenue(completedBookings);
    final topEarningSpots = _getTopEarningSpots(completedBookings);

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
          'Revenue Analytics',
          style: GoogleFonts.poppins(
            fontSize: 18,
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
            // Revenue overview cards
            Row(
              children: [
                Expanded(
                  child: _buildRevenueCard(
                    'Total Revenue',
                    '₹${totalRevenue.toStringAsFixed(0)}',
                    Icons.account_balance_wallet,
                    AppColors.success,
                    '${completedBookings.length} transactions',
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRevenueCard(
                    'Avg. Booking',
                    '₹${averageBookingValue.toStringAsFixed(0)}',
                    Icons.trending_up,
                    AppColors.primary,
                    'per booking',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildRevenueCard(
                    'This Month',
                    '₹${monthlyRevenue.toStringAsFixed(0)}',
                    Icons.calendar_month,
                    AppColors.accent,
                    DateTime.now().month.toString() + '/' + DateTime.now().year.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRevenueCard(
                    'Active Spots',
                    '${provider.approvedParkingSpots.length}',
                    Icons.local_parking,
                    AppColors.warning,
                    'earning spots',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),

            // Top earning spots
            Text(
              'TOP EARNING SPOTS',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textHint,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            if (topEarningSpots.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'No revenue data available',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.textHint,
                    ),
                  ),
                ),
              )
            else
              ...topEarningSpots.asMap().entries.map((entry) {
                final index = entry.key;
                final spotData = entry.value;
                return _buildEarningSpotCard(spotData, index + 1);
              }),
            const SizedBox(height: 28),

            // Recent transactions
            Text(
              'RECENT TRANSACTIONS',
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textHint,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            ...completedBookings.take(5).map((booking) => _buildTransactionCard(booking)),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueCard(String title, String value, IconData icon, Color color, String subtitle) {
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
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            subtitle,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEarningSpotCard(Map<String, dynamic> spotData, int rank) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: _getRankColor(rank).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                '#$rank',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: _getRankColor(rank),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  spotData['name'],
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${spotData['bookings']} bookings',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${spotData['revenue'].toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionCard(Booking booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.success.withOpacity(0.1),
            child: Icon(
              Icons.check_circle,
              size: 16,
              color: AppColors.success,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  booking.parkingName,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '${booking.userName} • ${_formatDate(booking.startTime)}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '₹${booking.totalPrice.toStringAsFixed(0)}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.success,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalRevenue(List<Booking> bookings) {
    return bookings.fold(0.0, (sum, booking) => sum + booking.totalPrice);
  }

  double _calculateMonthlyRevenue(List<Booking> bookings) {
    final currentMonth = DateTime.now().month;
    final currentYear = DateTime.now().year;
    
    return bookings
        .where((b) => b.startTime.month == currentMonth && b.startTime.year == currentYear)
        .fold(0.0, (sum, booking) => sum + booking.totalPrice);
  }

  List<Map<String, dynamic>> _getTopEarningSpots(List<Booking> bookings) {
    final Map<String, Map<String, dynamic>> spotRevenue = {};
    
    for (final booking in bookings) {
      if (!spotRevenue.containsKey(booking.parkingName)) {
        spotRevenue[booking.parkingName] = {
          'name': booking.parkingName,
          'revenue': 0.0,
          'bookings': 0,
        };
      }
      spotRevenue[booking.parkingName]!['revenue'] += booking.totalPrice;
      spotRevenue[booking.parkingName]!['bookings'] += 1;
    }
    
    final sortedSpots = spotRevenue.values.toList()
      ..sort((a, b) => b['revenue'].compareTo(a['revenue']));
    
    return sortedSpots.take(5).toList();
  }

  Color _getRankColor(int rank) {
    switch (rank) {
      case 1:
        return AppColors.starYellow;
      case 2:
        return AppColors.textSecondary;
      case 3:
        return AppColors.accent;
      default:
        return AppColors.primary;
    }
  }

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
