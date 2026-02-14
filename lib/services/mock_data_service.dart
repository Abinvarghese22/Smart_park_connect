import '../models/parking_spot.dart';
import '../models/booking.dart';
import '../models/user_model.dart';

/// Service providing mock data for the entire application
/// Replace with real API calls when backend is ready
class MockDataService {
  MockDataService._();

  // ---------- CURRENT USER ----------
  static const UserModel currentUser = UserModel(
    id: 'u1',
    name: 'John Doe',
    phone: '+91 98765 43210',
    email: 'john.doe@email.com',
    avatarUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
    isVerifiedOwner: true,
    totalBookings: 12,
    totalParkings: 3,
    earnings: 24500.0,
  );

  // ---------- PARKING SPOTS ----------
  static const List<ParkingSpot> parkingSpots = [
    ParkingSpot(
      id: 'p1',
      name: 'Urban Parking Station',
      address: '452 Premium Enclave, Silicon Heights, Sector 62, Bangalore',
      rating: 4.8,
      reviewCount: 120,
      pricePerHour: 50,
      distance: 0.3,
      walkTime: 5,
      amenities: ['COVERED', 'CCTV', 'EV CHARGE', '24/7'],
      tags: ['COVERED', 'CCTV'],
      imageUrl: 'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=400',
      galleryImages: [
        'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=800',
        'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=800',
        'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=800',
        'https://images.unsplash.com/photo-1621929747188-0b4dc28498d2?w=800',
        'https://images.unsplash.com/photo-1470224114660-3f6686c562eb?w=800',
      ],
      ownerName: 'Arjun Sharma',
      ownerAvatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=100',
      description:
          'Secure and spacious parking spot located in the heart of Silicon Heights. Features wide ramps for easy entry, high-definition 4K CCTV surveillance, and specialized bays for SUVs and Electric Vehicles.',
      latitude: 12.9716,
      longitude: 77.5946,
      type: 'covered',
    ),
    ParkingSpot(
      id: 'p2',
      name: 'Skyline Premier Garage',
      address: 'MG Road, Central Business District, Bangalore',
      rating: 4.8,
      reviewCount: 95,
      pricePerHour: 40,
      distance: 0.4,
      walkTime: 7,
      amenities: ['COVERED', 'CCTV'],
      tags: ['COVERED'],
      imageUrl: 'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=400',
      galleryImages: [
        'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=800',
        'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=800',
      ],
      ownerName: 'Priya Patel',
      ownerAvatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=100',
      description:
          'Premium covered garage with 24/7 security and CCTV monitoring. Conveniently located near MG Road metro station.',
      latitude: 12.9756,
      longitude: 77.6066,
      type: 'covered',
    ),
    ParkingSpot(
      id: 'p3',
      name: 'Plaza Secure Spot',
      address: 'Indiranagar, Old Madras Road, Bangalore',
      rating: 4.6,
      reviewCount: 85,
      pricePerHour: 75,
      distance: 0.7,
      walkTime: 10,
      amenities: ['EV CHARGING', 'VALET'],
      tags: ['EV CHARGING', 'VALET'],
      imageUrl: 'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=400',
      galleryImages: [
        'https://images.unsplash.com/photo-1506521781263-d8422e82f27a?w=800',
        'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=800',
      ],
      ownerName: 'Rahul Verma',
      ownerAvatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=100',
      description:
          'Modern parking facility with EV charging stations and valet service. Located in the heart of Indiranagar.',
      latitude: 12.9784,
      longitude: 77.6408,
      type: 'open',
    ),
    ParkingSpot(
      id: 'p4',
      name: 'Green Heights Driveway',
      address: 'Koramangala 5th Block, Startup Hub District',
      rating: 4.9,
      reviewCount: 42,
      pricePerHour: 30,
      distance: 1.2,
      walkTime: 15,
      amenities: ['CCTV'],
      tags: ['RESIDENTIAL', 'VERIFIED'],
      imageUrl: 'https://images.unsplash.com/photo-1621929747188-0b4dc28498d2?w=400',
      galleryImages: [
        'https://images.unsplash.com/photo-1621929747188-0b4dc28498d2?w=800',
      ],
      ownerName: 'Sneha Reddy',
      ownerAvatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=100',
      description:
          'Quiet residential driveway parking in a gated community. Perfect for long-term parking needs.',
      latitude: 12.9352,
      longitude: 77.6245,
      type: 'open',
    ),
    ParkingSpot(
      id: 'p5',
      name: 'Eco-Charge Park',
      address: 'HSR Layout, Sector 2, Bangalore',
      rating: 4.5,
      reviewCount: 67,
      pricePerHour: 35,
      distance: 0.8,
      walkTime: 12,
      amenities: ['EV CHARGING', 'COVERED', 'CCTV'],
      tags: ['EV CHARGING', 'COVERED'],
      imageUrl: 'https://images.unsplash.com/photo-1470224114660-3f6686c562eb?w=400',
      galleryImages: [
        'https://images.unsplash.com/photo-1470224114660-3f6686c562eb?w=800',
      ],
      ownerName: 'Vikram Singh',
      ownerAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100',
      description:
          'Eco-friendly parking with solar-powered EV charging. Covered bays with rainwater harvesting.',
      latitude: 12.9121,
      longitude: 77.6446,
      type: 'covered',
    ),
  ];

  // ---------- RECENT SEARCHES ----------
  static const List<Map<String, String>> recentSearches = [
    {'title': 'MG Road, Bangalore', 'subtitle': 'Central Business District'},
    {'title': 'Indiranagar Metro', 'subtitle': 'Old Madras Road, Bangalore'},
    {'title': 'Koramangala 5th Block', 'subtitle': 'Startup Hub District'},
  ];

  // ---------- POPULAR LOCATIONS ----------
  static const List<Map<String, String>> popularLocations = [
    {'title': 'City Center Mall', 'subtitle': 'Brigade Road, Bangalore'},
    {'title': 'UB City', 'subtitle': 'Vittal Mallya Road'},
    {'title': 'Phoenix Marketcity', 'subtitle': 'Whitefield, Bangalore'},
  ];

  // ---------- FILTER CHIPS ----------
  static const List<String> quickFilters = [
    'All',
    'Under \u20B950',
    '\u2605 4.5+',
    'Covered',
    'EV Charging',
    'CCTV',
    '24/7',
  ];

  // ---------- POPULAR DURATIONS ----------
  static const List<String> popularDurations = [
    '1 hr',
    '2 hrs',
    '4 hrs',
    'Full Day',
  ];

  // ---------- SAMPLE BOOKINGS ----------
  static List<Booking> sampleBookings = [
    Booking(
      id: 'b1',
      parkingSpotId: 'p1',
      parkingName: 'Central Plaza Parking',
      parkingAddress: 'MG Road, Bangalore',
      parkingImage: 'https://images.unsplash.com/photo-1590674899484-d5640e854abe?w=400',
      startTime: DateTime(2023, 10, 12, 10, 0),
      endTime: DateTime(2023, 10, 12, 14, 0),
      totalPrice: 120.0,
      basePrice: 100.0,
      serviceFee: 10.0,
      gst: 10.0,
      status: 'confirmed',
    ),
    Booking(
      id: 'b2',
      parkingSpotId: 'p2',
      parkingName: 'Skyline Premier Garage',
      parkingAddress: 'MG Road, Bangalore',
      parkingImage: 'https://images.unsplash.com/photo-1573348722427-f1d6819fdf98?w=400',
      startTime: DateTime(2023, 10, 10, 9, 0),
      endTime: DateTime(2023, 10, 10, 12, 0),
      totalPrice: 90.0,
      basePrice: 75.0,
      serviceFee: 8.0,
      gst: 7.0,
      status: 'completed',
    ),
  ];
}
