import 'package:ecommerce_app/core/di/injection.dart';
import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/view/main_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signin_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:ecommerce_app/features/intro/presentation/views/onboarding_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final AuthViewModel authViewModel = getIt<AuthViewModel>();
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 2500), () {
      if (authViewModel.isFirstTime) {
        Get.off(() => const OnboardingScreen());
      } else if (authViewModel.isLoggedIn) {
        Get.off(() => const MainScreen());
      } else {
        Get.off(() => SignInScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor, // Top color
              Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.8), // Middle color
              Theme.of(
                context,
              ).primaryColor.withValues(alpha: 0.6), // Bottom color
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.05,
                child: GridPattern(color: AppColors.white),
              ),
            ),

            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          padding: EdgeInsets.all(24.w),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.shadow,
                                blurRadius: 10.r,
                                spreadRadius: 2.r,
                                offset: Offset(0, 4.h),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            size: 48.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),

                  // animated text that fades in and out
                  TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0.0, end: 1.0),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(
                            0,
                            (1 - value) * 20.h,
                          ), // Slide up effect
                          child: Column(
                            children: [
                              Text(
                                easy.tr(LocaleKeys.splash_title),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 8.w,
                                ),
                              ),
                              Text(
                                easy.tr(LocaleKeys.splash_store),
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 32.sp,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 4.w,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // bottom tagline
            Positioned(
              bottom: 32.h,
              left: 0,
              right: 0,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 1200),
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 20.h), // Slide up effect
                      child: Text(
                        easy.tr(LocaleKeys.splash_tagline),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.white.withValues(alpha: 0.8),
                          fontSize: 16.sp,
                          letterSpacing: 2.w,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GridPattern extends StatelessWidget {
  final Color color;

  const GridPattern({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: GridPainter(color: color));
  }
}

class GridPainter extends CustomPainter {
  final Color color;

  GridPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 0;

    double gridSize = 20.0.w;

    for (double x = 0; x < size.width; x += gridSize) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += gridSize) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
