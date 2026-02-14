import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../services/mock_data_service.dart';
import '../../services/location_service.dart';
import '../search/search_results_screen.dart';

/// Search locations screen with search bar, recent searches, popular locations
/// Matches reference: search_locations/screen.png
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;
  String _currentLocationText = 'Using GPS • High accuracy';

  @override
  void initState() {
    super.initState();
    // Auto-focus search field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
    
    // Listen to text changes
    _searchController.addListener(() {
      setState(() {
        _hasText = _searchController.text.isNotEmpty;
      });
    });
    
    // Initialize current location
    _initializeCurrentLocation();
  }
  
  Future<void> _initializeCurrentLocation() async {
    try {
      final location = await LocationService.instance.getCurrentLocation();
      if (location != null) {
        setState(() {
          _currentLocationText = 'Using GPS • High accuracy';
        });
      } else {
        setState(() {
          _currentLocationText = 'Location unavailable';
        });
      }
    } catch (e) {
      setState(() {
        _currentLocationText = 'Location unavailable';
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) return;
    
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SearchResultsScreen(query: query.trim()),
      ),
    );
  }
  
  void _useCurrentLocation() async {
    final location = await LocationService.instance.getCurrentLocation();
    if (location != null) {
      _performSearch('Current Location');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to get current location. Please check location permissions.',
            style: GoogleFonts.poppins(fontSize: 14),
          ),
          backgroundColor: AppColors.error,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search bar with back button and clear
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 12, 20, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back,
                        color: AppColors.textPrimary),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Container(
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              focusNode: _focusNode,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Search location...',
                                hintStyle: GoogleFonts.poppins(
                                  color: AppColors.textHint,
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                              ),
                              onSubmitted: _performSearch,
                            ),
                          ),
                          if (_hasText)
                            GestureDetector(
                              onTap: () {
                                _searchController.clear();
                                _focusNode.requestFocus();
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(right: 12),
                                child: Icon(Icons.clear,
                                    color: AppColors.textHint, size: 20),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      _focusNode.requestFocus();
                    },
                    child: Text(
                      'Clear',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Current Location tile
            _buildCurrentLocationTile(),
            const SizedBox(height: 8),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Recent Searches section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Text(
                        AppStrings.recentSearches,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textHint,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...MockDataService.recentSearches.map((item) {
                      return _buildSearchItem(
                        icon: Icons.access_time,
                        title: item['title']!,
                        subtitle: item['subtitle']!,
                        onTap: () => _performSearch(item['title']!),
                      );
                    }),

                    const SizedBox(height: 8),
                    // Divider
                    Container(
                      height: 8,
                      color: AppColors.backgroundLight,
                    ),

                    // Popular Locations section
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                      child: Text(
                        AppStrings.popularLocations,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textHint,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    ...MockDataService.popularLocations.map((item) {
                      return _buildSearchItem(
                        icon: Icons.location_city,
                        title: item['title']!,
                        subtitle: item['subtitle']!,
                        onTap: () => _performSearch(item['title']!),
                        showImage: true,
                      );
                    }),
                    // Add bottom padding for keyboard
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCurrentLocationTile() {
    return InkWell(
      onTap: _useCurrentLocation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.my_location,
                  color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.currentLocation,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  _currentLocationText,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool showImage = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          children: [
            if (showImage)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.shimmerBase,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.image,
                    color: AppColors.textHint, size: 20),
              )
            else
              Icon(icon, color: AppColors.textHint, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
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
            const Icon(Icons.north_west,
                color: AppColors.textHint, size: 18),
          ],
        ),
      ),
    );
  }
}
