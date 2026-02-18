import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../providers/app_provider.dart';
import '../../widgets/parking_card.dart';
import '../parking/parking_details_screen.dart';
import '../parking/slot_selection_screen.dart';

/// Search results screen showing parking spots list with sort/filter
/// Matches reference: parking_search_results/screen.png
class SearchResultsScreen extends StatelessWidget {
  final String query;
  final double? latitude;
  final double? longitude;

  const SearchResultsScreen({
    super.key,
    required this.query,
    this.latitude,
    this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final spots = provider.parkingSpots;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: SafeArea(
        child: Column(
          children: [
            // App bar with back button and title
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.searchResults,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  // Map toggle button
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.map_outlined,
                        color: Colors.white, size: 20),
                  ),
                ],
              ),
            ),
            // Count + Sort/Filter row
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  Text(
                    '${spots.length * 5} ${AppStrings.spacesNearYou}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Spacer(),
                  _buildFilterChip(Icons.sort, AppStrings.sort),
                  const SizedBox(width: 8),
                  _buildFilterChip(Icons.tune, AppStrings.filter),
                ],
              ),
            ),
            // Results list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 4, bottom: 80),
                itemCount: spots.length,
                itemBuilder: (context, index) {
                  final spot = spots[index];
                  return ParkingCard(
                    spot: spot,
                    isFavorite: provider.isFavorite(spot.id),
                    onTap: () {
                      provider.selectSpot(spot);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => ParkingDetailsScreen(spot: spot),
                        ),
                      );
                    },
                    onFavoriteTap: () => provider.toggleFavorite(spot.id),
                    onBookTap: () {
                      provider.selectSpot(spot);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              SlotSelectionScreen(spot: spot),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // Show on Map FAB
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 8),
        child: FloatingActionButton.extended(
          onPressed: () {},
          backgroundColor: AppColors.textPrimary,
          foregroundColor: Colors.white,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          icon: const Icon(Icons.map_outlined, size: 18),
          label: Text(
            AppStrings.showOnMap,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildFilterChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.cardBorder),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppColors.textPrimary),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
