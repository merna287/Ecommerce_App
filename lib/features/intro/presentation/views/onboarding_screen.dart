import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/core/di/injection.dart';
import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:ecommerce_app/core/utils/app_assets.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signin_screen.dart';
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:ecommerce_app/features/intro/presentation/models/onboarding_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  final List<OnboardingItem> _items = [
    OnboardingItem(
      imagePath: AppAssets.onboardingImage1,
      titleKey: LocaleKeys.onboarding_title1,
      descriptionKey: LocaleKeys.onboarding_description1,
    ),
    OnboardingItem(
      imagePath: AppAssets.onboardingImage2,
      titleKey: LocaleKeys.onboarding_title2,
      descriptionKey: LocaleKeys.onboarding_description2,
    ),
    OnboardingItem(
      imagePath: AppAssets.onboardingImage3,
      titleKey: LocaleKeys.onboarding_title3,
      descriptionKey: LocaleKeys.onboarding_description3,
    ),
  ];

  void _handleGetStarted() {
    final AuthViewModel authViewModel = getIt<AuthViewModel>();
    authViewModel.setFirstTimeDone();
    Get.off(() => SignInScreen());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _items.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final item = _items[index];

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item.imagePath, height: 0.4.sh),

                  SizedBox(height: 40.h),
                  Text(
                    easy.tr(item.titleKey),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.withColor(
                      AppTextStyles.heading1,
                      Theme.of(context).textTheme.bodyLarge?.color ??
                          AppColors.black,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.w),
                    child: Text(
                      easy.tr(item.descriptionKey),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyLarge,
                        isDark ? AppColors.grey400 : AppColors.grey600,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          Positioned(
            bottom: 80.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _items.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentPage == index ? 24.w : 8.w,
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? Theme.of(context).primaryColor
                        : (isDark ? AppColors.grey700 : AppColors.grey300),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 16.h,
            left: 16.w,
            right: 16.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: _handleGetStarted,
                  child: Text(
                    easy.tr(LocaleKeys.buttons_skip),
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      isDark ? AppColors.grey400 : AppColors.grey600,
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (_currentPage < _items.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    } else {
                      _handleGetStarted();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    _currentPage == _items.length - 1
                        ? easy.tr(LocaleKeys.buttons_getStarted)
                        : easy.tr(LocaleKeys.buttons_next),
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
