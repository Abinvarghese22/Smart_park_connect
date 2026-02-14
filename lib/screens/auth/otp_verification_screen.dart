// DEPRECATED: This screen is no longer used. Auth is now email/password based.
import 'package:flutter/material.dart';

/// OTP verification screen (DEPRECATED - replaced by email/password auth)
class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('This screen is deprecated. Use email/password login.'),
      ),
    );
  }
}
