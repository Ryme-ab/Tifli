import 'package:flutter/material.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_fonts.dart';
import '../core/constants/app_sizes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F6), // 🎀 Baby pink background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40), // Push everything down
              /// ✨ Title — smaller, fine font, lighter black
              Padding(
                padding: const EdgeInsets.only(top: AppSizes.xxl, bottom: AppSizes.sm), // Move text up by adding space below
                child: Text(
                  "Your Child’s Journey.\nBeautifully Tracked.",
                  textAlign: TextAlign.center,
                  style: AppFonts.body.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black54, // lighter black
                    height: 1.4,
                    fontFamily: 'OpenSans', // fine & modern font
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.xxl), // More space after text

              /// 🖼️ Logo — bigger and moved slightly more to the right
              Align(
                alignment: Alignment.center, // centered horizontally and vertically
                child: Padding(
                  padding: const EdgeInsets.only(top: 80.0), // Increased top padding to push logo down
                  child: Image.asset(
                    'assets/images/splash_screen.png',
                    width: 230, // a bit larger
                    height: 230,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

                const Spacer(flex: 3), // Increased flex more to push button further down

              /// 🚀 Get started button — ensure white text, no blue
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
                child: SizedBox(
                  width: double.infinity,
                  height: AppSizes.buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/onboarding');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white, // ✅ fixes text turning blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSizes.radius),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Get started',
                      style: const TextStyle(
                        color: Color.fromARGB(255, 247, 231, 231),
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                        fontFamily: 'OpenSans',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: AppSizes.xl), // Add extra space below button
            ],
          ),
        ),
      ),
    );
  }
}
