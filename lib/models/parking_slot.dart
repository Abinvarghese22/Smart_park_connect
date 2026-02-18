import 'dart:convert';

/// Model representing a single bookable parking slot inside a parking plot.
/// e.g., A1, A2, B1, B2 inside "MG Road Parking"
class ParkingSlot {
  final String id;               // Unique ID, e.g., 'spot_001_A1'
  final String spotId;           // Parent ParkingSpot.id
  final String label;            // Display label, e.g., 'A1'
  final String status;           // 'available' | 'booked'
  final String? bookedByUserId;  // User who booked this slot
  final String? bookingId;       // Linked Booking.id

  const ParkingSlot({
    required this.id,
    required this.spotId,
    required this.label,
    this.status = 'available',
    this.bookedByUserId,
    this.bookingId,
  });

  /// Returns true if this slot can be booked
  bool get isAvailable => status == 'available';

  ParkingSlot copyWith({
    String? id,
    String? spotId,
    String? label,
    String? status,
    String? bookedByUserId,
    String? bookingId,
  }) =>
      ParkingSlot(
        id: id ?? this.id,
        spotId: spotId ?? this.spotId,
        label: label ?? this.label,
        status: status ?? this.status,
        bookedByUserId: bookedByUserId ?? this.bookedByUserId,
        bookingId: bookingId ?? this.bookingId,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'spotId': spotId,
        'label': label,
        'status': status,
        'bookedByUserId': bookedByUserId,
        'bookingId': bookingId,
      };

  factory ParkingSlot.fromJson(Map<String, dynamic> json) => ParkingSlot(
        id: json['id'] ?? '',
        spotId: json['spotId'] ?? '',
        label: json['label'] ?? '',
        status: json['status'] ?? 'available',
        bookedByUserId: json['bookedByUserId'],
        bookingId: json['bookingId'],
      );

  String toJsonString() => jsonEncode(toJson());

  factory ParkingSlot.fromJsonString(String s) =>
      ParkingSlot.fromJson(jsonDecode(s));
}
