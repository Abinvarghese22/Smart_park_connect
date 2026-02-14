# Smart Park Connect

**Intelligent Parking Management System** - A mobile-based parking space sharing platform that connects drivers with private parking space owners.

## Features

### User Module
- **Splash Screen** - Animated blue splash with app logo
- **Onboarding** - 3-page walkthrough with page indicators
- **Phone Authentication** - OTP-based login with social sign-in options
- **Home/Explore** - Map view with floating search bar and nearby parking
- **Search** - Location search with recent searches and popular locations
- **Search Results** - Parking list with sort/filter, "Show on Map" FAB
- **Parking Details** - Image gallery, amenities, host info, location map
- **Booking Time** - Calendar, time pickers, duration chips, price estimate
- **Payment** - Booking summary, payment method, price breakdown, coupon
- **Booking Confirmation** - Animated success screen
- **Profile** - User info, activity, preferences, system settings

### Owner Module
- **Owner Dashboard** - Stats, quick actions, recent bookings
- **Add Parking Space** - Form with image upload, amenities, pricing
- **Manage Bookings** - Approve/decline incoming bookings
- **Earnings Overview** - Revenue analytics and monthly breakdown

### Admin Module
- **Admin Dashboard** - Platform stats, management actions
- **User Management** - View/manage all users with roles and status
- **Parking Approvals** - Review and approve/reject new listings

## Tech Stack

- **Framework**: Flutter 3.x with Dart
- **State Management**: Provider
- **Design System**: Material 3
- **Fonts**: Google Fonts (Poppins)
- **Architecture**: Clean modular architecture

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── core/
│   ├── constants/
│   │   ├── app_colors.dart      # Color palette
│   │   └── app_strings.dart     # String constants
│   └── theme/
│       └── app_theme.dart       # Light & dark themes
├── models/
│   ├── parking_spot.dart        # Parking spot model
│   ├── booking.dart             # Booking model
│   └── user_model.dart          # User model
├── services/
│   └── mock_data_service.dart   # Mock data for all screens
├── providers/
│   └── app_provider.dart        # Global state management
├── navigation/
│   └── main_navigation.dart     # Bottom nav shell
├── widgets/
│   ├── shimmer_loading.dart     # Shimmer/skeleton widgets
│   └── parking_card.dart        # Reusable parking cards
└── screens/
    ├── splash/
    │   └── splash_screen.dart
    ├── onboarding/
    │   └── onboarding_screen.dart
    ├── auth/
    │   ├── phone_auth_screen.dart
    │   └── otp_verification_screen.dart
    ├── home/
    │   ├── home_screen.dart
    │   └── saved_screen.dart
    ├── search/
    │   ├── search_screen.dart
    │   └── search_results_screen.dart
    ├── parking/
    │   └── parking_details_screen.dart
    ├── booking/
    │   ├── select_booking_time_screen.dart
    │   └── bookings_screen.dart
    ├── payment/
    │   ├── payment_screen.dart
    │   └── booking_confirmation_screen.dart
    ├── profile/
    │   └── profile_screen.dart
    ├── owner/
    │   └── owner_dashboard_screen.dart
    └── admin/
        └── admin_dashboard_screen.dart
```

## Getting Started

1. Ensure Flutter SDK is installed and in your PATH
2. Navigate to the project directory:
   ```bash
   cd smart_park_connect
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## Design Reference

The UI is designed to match the reference images provided, featuring:
- Clean minimal design inspired by Uber/Airbnb
- Rounded cards with soft shadows
- Purple/blue primary color scheme (#5B4CFF)
- Bottom navigation with elevated center "Host" button
- Smooth page transitions and animations
- Shimmer loading effects
- Light and dark theme support

## Notes

- All data is currently mocked via `MockDataService`
- Google Maps integration uses placeholder custom painters
- Network images use Unsplash URLs as placeholders
- The app is structured for easy API integration when backend is ready
