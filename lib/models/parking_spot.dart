/// Model representing a parking space listing
class ParkingSpot {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;
  final double pricePerHour;
  final double distance; // in km
  final int walkTime; // in minutes
  final List<String> amenities; // e.g. COVERED, CCTV, EV CHARGING, VALET, 24/7
  final List<String> tags; // e.g. RESIDENTIAL, VERIFIED
  final String imageUrl;
  final List<String> galleryImages;
  final String ownerName;
  final String ownerAvatar;
  final String description;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final String type; // covered, open, underground

  const ParkingSpot({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.pricePerHour,
    required this.distance,
    required this.walkTime,
    required this.amenities,
    required this.tags,
    required this.imageUrl,
    required this.galleryImages,
    required this.ownerName,
    required this.ownerAvatar,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.isAvailable = true,
    this.type = 'covered',
  });
}
