/// Model representing a parking booking
class Booking {
  final String id;
  final String parkingSpotId;
  final String parkingName;
  final String parkingAddress;
  final String parkingImage;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;
  final double basePrice;
  final double serviceFee;
  final double gst;
  final String status; // confirmed, active, completed, cancelled
  final String paymentMethod;

  const Booking({
    required this.id,
    required this.parkingSpotId,
    required this.parkingName,
    required this.parkingAddress,
    required this.parkingImage,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
    required this.basePrice,
    required this.serviceFee,
    required this.gst,
    this.status = 'confirmed',
    this.paymentMethod = 'Visa •••• 4242',
  });

  /// Duration in hours
  double get durationHours =>
      endTime.difference(startTime).inMinutes / 60.0;

  /// Formatted duration string
  String get durationFormatted {
    final hours = endTime.difference(startTime).inHours;
    final mins = endTime.difference(startTime).inMinutes % 60;
    if (mins == 0) return '$hours Hours';
    return '$hours hours $mins mins';
  }
}
