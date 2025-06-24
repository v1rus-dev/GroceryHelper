import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groceryhelper/core/constants/app_assets.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.text = 'Sign in with Google',
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0)),
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.googleLogo, height: 24, width: 24),
          Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        ],
      ),
    );
  }
}
