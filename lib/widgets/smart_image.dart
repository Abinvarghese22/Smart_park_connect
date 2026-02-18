import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/constants/app_colors.dart';

/// A smart image widget that automatically detects whether the image source
/// is a local file path or a network URL and renders accordingly.
/// Used across all roles (User, Owner, Admin) to display parking spot images.
class SmartImage extends StatelessWidget {
  final String imageSource;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const SmartImage({
    super.key,
    required this.imageSource,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  bool get _isLocalFile {
    return imageSource.startsWith('/') ||
        imageSource.startsWith('file://') ||
        imageSource.contains(':\\') ||
        imageSource.contains(':/');
  }

  bool get _isNetworkUrl {
    return imageSource.startsWith('http://') ||
        imageSource.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    Widget image;

    if (imageSource.isEmpty) {
      image = _buildPlaceholder();
    } else if (_isLocalFile) {
      final file = File(imageSource.replaceFirst('file://', ''));
      if (file.existsSync()) {
        image = Image.file(
          file,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        image = _buildPlaceholder();
      }
    } else if (_isNetworkUrl) {
      image = Image.network(
        imageSource,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, __, ___) => _buildPlaceholder(),
      );
    } else {
      image = _buildPlaceholder();
    }

    if (borderRadius != null) {
      return ClipRRect(
        borderRadius: borderRadius!,
        child: image,
      );
    }
    return image;
  }

  Widget _buildPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: (height ?? 80) * 0.3,
              color: AppColors.textHint.withValues(alpha: 0.4),
            ),
            if ((height ?? 80) > 60) ...[
              const SizedBox(height: 4),
              Text(
                'No Image',
                style: GoogleFonts.poppins(
                  fontSize: (height ?? 80) * 0.12,
                  color: AppColors.textHint.withValues(alpha: 0.5),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
