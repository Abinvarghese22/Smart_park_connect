import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../models/parking_spot.dart';
import '../booking/select_booking_time_screen.dart';

/// Parking spot details screen with image gallery, amenities, host info, map
/// Matches reference: parking_spot_details/screen.png
class ParkingDetailsScreen extends StatefulWidget {
  final ParkingSpot spot;

  const ParkingDetailsScreen({super.key, required this.spot});

  @override
  State<ParkingDetailsScreen> createState() => _ParkingDetailsScreenState();
}

class _ParkingDetailsScreenState extends State<ParkingDetailsScreen> {
  int _currentImageIndex = 0;
  final PageController _imagePageController = PageController();
  bool _showFullDescription = false;

  @override
  void dispose() {
    _imagePageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spot = widget.spot;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Scrollable content
          CustomScrollView(
            slivers: [
              // Image gallery with overlay buttons
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Image carousel
                    SizedBox(
                      height: 280,
                      child: PageView.builder(
                        controller: _imagePageController,
                        itemCount: spot.galleryImages.length,
                        onPageChanged: (index) {
                          setState(() => _currentImageIndex = index);
                        },
                        itemBuilder: (context, index) {
                          return Image.network(
                            spot.galleryImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Container(
                              color: AppColors.shimmerBase,
                              child: const Center(
                                child: Icon(Icons.local_parking,
                                    size: 60, color: AppColors.textHint),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    // Top overlay buttons
                    Positioned(
                      top: MediaQuery.of(context).padding.top + 8,
                      left: 16,
                      right: 16,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCircleButton(
                            Icons.arrow_back,
                            () => Navigator.pop(context),
                          ),
                          Row(
                            children: [
                              _buildCircleButton(Icons.share, () {}),
                              const SizedBox(width: 8),
                              _buildCircleButton(Icons.favorite_border, () {}),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Image counter
                    Positioned(
                      bottom: 12,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${_currentImageIndex + 1}/${spot.galleryImages.length}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name + Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              spot.name,
                              style: GoogleFonts.poppins(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star,
                                    color: AppColors.starYellow, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${spot.rating}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      // Address
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              spot.address,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Host info card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            // Owner avatar
                            CircleAvatar(
                              radius: 22,
                              backgroundImage:
                                  NetworkImage(spot.ownerAvatar),
                              onBackgroundImageError: (_, __) {},
                              child: const Icon(Icons.person),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.hostedBy,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    spot.ownerName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {},
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: const BorderSide(
                                    color: AppColors.primary, width: 1.5),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 8),
                              ),
                              child: Text(
                                AppStrings.message,
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Amenities
                      Text(
                        AppStrings.amenities,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: spot.amenities.map((amenity) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: _buildAmenityItem(amenity),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // About this space
                      Text(
                        AppStrings.aboutThisSpace,
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        spot.description,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.6,
                        ),
                        maxLines: _showFullDescription ? null : 3,
                        overflow: _showFullDescription
                            ? null
                            : TextOverflow.ellipsis,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showFullDescription = !_showFullDescription;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            _showFullDescription
                                ? 'Show less'
                                : AppStrings.readMore,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Location section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            AppStrings.location,
                            style: GoogleFonts.poppins(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              AppStrings.openInMaps,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Map placeholder
                      Container(
                        height: 160,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Stack(
                          children: [
                            // Simulated map
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CustomPaint(
                                size: const Size(double.infinity, 160),
                                painter: _MiniMapPainter(),
                              ),
                            ),
                            // Pin marker
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.location_on,
                                      color: AppColors.primary, size: 36),
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.primary.withOpacity(0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bottom padding for the fixed bar
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Bottom fixed price + book bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 16,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Price
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        AppStrings.totalPrice,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '\u20B9${spot.pricePerHour.toInt()}',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            ' / hr',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  // Book Now button
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) =>
                              SelectBookingTimeScreen(spot: spot),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      AppStrings.bookNow,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircleButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }

  Widget _buildAmenityItem(String amenity) {
    IconData icon;
    switch (amenity.toUpperCase()) {
      case 'COVERED':
        icon = Icons.umbrella;
        break;
      case 'CCTV':
        icon = Icons.videocam;
        break;
      case 'EV CHARGE':
      case 'EV CHARGING':
        icon = Icons.ev_station;
        break;
      case '24/7':
        icon = Icons.access_time_filled;
        break;
      case 'VALET':
        icon = Icons.directions_car;
        break;
      default:
        icon = Icons.check_circle;
    }

    return Column(
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.backgroundLight,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Icon(icon, color: AppColors.primary, size: 24),
        ),
        const SizedBox(height: 6),
        Text(
          amenity,
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

/// Mini map painter for the location section
class _MiniMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Light green/blue map background
    final bgPaint = Paint()..color = const Color(0xFFE0F2F1);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Roads
    final roadPaint = Paint()
      ..color = Colors.white.withOpacity(0.8)
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(0, size.height * 0.4),
        Offset(size.width, size.height * 0.4),
        roadPaint);
    canvas.drawLine(
        Offset(size.width * 0.5, 0),
        Offset(size.width * 0.5, size.height),
        roadPaint);
    canvas.drawLine(
        Offset(0, size.height * 0.7),
        Offset(size.width, size.height * 0.7),
        roadPaint);

    // Blocks
    final blockPaint = Paint()..color = const Color(0xFFB2DFDB);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(10, 10, size.width * 0.35, size.height * 0.25),
        const Radius.circular(4),
      ),
      blockPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width * 0.6, size.height * 0.5,
            size.width * 0.3, size.height * 0.15),
        const Radius.circular(4),
      ),
      blockPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
