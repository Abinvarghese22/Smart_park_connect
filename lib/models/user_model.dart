import 'dart:convert';

/// User roles in the system: Admin, User (driver), Owner
enum UserRole { admin, user, owner }

/// Model representing a user (driver or owner)
class UserModel {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String password;
  final String avatarUrl;
  final UserRole role;
  final bool isVerifiedOwner;
  final int totalBookings;
  final int totalParkings;
  final double earnings;

  const UserModel({
    required this.id,
    required this.name,
    this.phone = '',
    this.email = '',
    this.password = '',
    this.avatarUrl = '',
    this.role = UserRole.user,
    this.isVerifiedOwner = false,
    this.totalBookings = 0,
    this.totalParkings = 0,
    this.earnings = 0.0,
  });

  /// Convert to JSON map for local storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'password': password,
        'avatarUrl': avatarUrl,
        'role': role.name,
        'isVerifiedOwner': isVerifiedOwner,
        'totalBookings': totalBookings,
        'totalParkings': totalParkings,
        'earnings': earnings,
      };

  /// Create from JSON map
  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] ?? '',
        name: json['name'] ?? '',
        phone: json['phone'] ?? '',
        email: json['email'] ?? '',
        password: json['password'] ?? '',
        avatarUrl: json['avatarUrl'] ?? '',
        role: UserRole.values.firstWhere(
          (r) => r.name == json['role'],
          orElse: () => UserRole.user,
        ),
        isVerifiedOwner: json['isVerifiedOwner'] ?? false,
        totalBookings: json['totalBookings'] ?? 0,
        totalParkings: json['totalParkings'] ?? 0,
        earnings: (json['earnings'] ?? 0.0).toDouble(),
      );

  /// Serialize to JSON string
  String toJsonString() => jsonEncode(toJson());

  /// Deserialize from JSON string
  factory UserModel.fromJsonString(String jsonStr) =>
      UserModel.fromJson(jsonDecode(jsonStr));

  /// Create a copy with updated fields
  UserModel copyWith({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? password,
    String? avatarUrl,
    UserRole? role,
    bool? isVerifiedOwner,
    int? totalBookings,
    int? totalParkings,
    double? earnings,
  }) =>
      UserModel(
        id: id ?? this.id,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        password: password ?? this.password,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        role: role ?? this.role,
        isVerifiedOwner: isVerifiedOwner ?? this.isVerifiedOwner,
        totalBookings: totalBookings ?? this.totalBookings,
        totalParkings: totalParkings ?? this.totalParkings,
        earnings: earnings ?? this.earnings,
      );

  /// Display-friendly role name
  String get roleDisplayName {
    switch (role) {
      case UserRole.admin:
        return 'Admin';
      case UserRole.owner:
        return 'Parking Owner';
      case UserRole.user:
        return 'Driver';
    }
  }
}
