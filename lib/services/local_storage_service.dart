import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

/// Local storage service for prototype authentication
/// Stores user accounts and session data on device using SharedPreferences
class LocalStorageService {
  static const String _usersKey = 'registered_users';
  static const String _currentUserKey = 'current_user';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _onboardingCompleteKey = 'onboarding_complete';

  // ---------- USER REGISTRATION ----------

  /// Register a new user locally. Returns error message or null on success.
  static Future<String?> registerUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    final users = await getAllUsers();

    // Check if email already exists
    final exists = users.any(
      (u) => u.email.toLowerCase() == user.email.toLowerCase(),
    );
    if (exists) {
      return 'An account with this email already exists.';
    }

    users.add(user);
    final jsonList = users.map((u) => u.toJsonString()).toList();
    await prefs.setStringList(_usersKey, jsonList);
    return null;
  }

  /// Get all registered users from local storage
  static Future<List<UserModel>> getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_usersKey) ?? [];
    return jsonList.map((s) => UserModel.fromJsonString(s)).toList();
  }

  // ---------- LOGIN / LOGOUT ----------

  /// Authenticate user with email and password. Returns UserModel or null.
  static Future<UserModel?> loginUser(String email, String password) async {
    final users = await getAllUsers();
    try {
      return users.firstWhere(
        (u) =>
            u.email.toLowerCase() == email.toLowerCase() &&
            u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  /// Save current logged-in user session
  static Future<void> saveSession(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_currentUserKey, user.toJsonString());
    await prefs.setBool(_isLoggedInKey, true);
  }

  /// Get current logged-in user from session
  static Future<UserModel?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_currentUserKey);
    if (jsonStr == null) return null;
    return UserModel.fromJsonString(jsonStr);
  }

  /// Check if user is logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  /// Clear session (logout)
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // ---------- ONBOARDING ----------

  /// Check if onboarding has been completed
  static Future<bool> isOnboardingComplete() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompleteKey) ?? false;
  }

  /// Mark onboarding as complete
  static Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompleteKey, true);
  }

  // ---------- SEED DEFAULT ADMIN ----------

  /// Seed a default admin account if none exists
  static Future<void> seedDefaultAdmin() async {
    final users = await getAllUsers();
    final hasAdmin = users.any((u) => u.role == UserRole.admin);
    if (!hasAdmin) {
      await registerUser(const UserModel(
        id: 'admin_001',
        name: 'Admin',
        email: 'admin@smartpark.com',
        password: 'admin123',
        role: UserRole.admin,
        isVerifiedOwner: true,
      ));
    }
  }
}
