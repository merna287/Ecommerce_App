import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:ecommerce_app/core/validators/validator_app.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark ? AppColors.white : AppColors.black,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                easy.tr(LocaleKeys.auth_resetPassword),
                style: AppTextStyles.withColor(
                  AppTextStyles.heading1,
                  Theme.of(context).textTheme.bodyLarge!.color!,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                easy.tr(LocaleKeys.auth_enterYourEmailToResetYourPassword),
                style: AppTextStyles.withColor(
                  AppTextStyles.bodyLarge,
                  isDark ? AppColors.grey400 : AppColors.grey600,
                ),
              ),
              SizedBox(height: 40.h),
              AppTextField(
                label: easy.tr(LocaleKeys.auth_email),
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: ValidatorApp.validateEmail,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final emailError = ValidatorApp.validateEmail(
                      _emailController.text.trim(),
                    );
                    if (emailError == null) {
                      showSuccessDialog(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    easy.tr(LocaleKeys.auth_sendResetLink),
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium,
                      AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          easy.tr(LocaleKeys.auth_checkYourEmail),
          style: AppTextStyles.heading1,
        ),
        content: Text(
          easy.tr(
            LocaleKeys.auth_weHaveSentPasswordRecoverInstructionsToYourEmail,
          ),
          style: AppTextStyles.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              easy.tr(LocaleKeys.auth_ok),
              style: AppTextStyles.withColor(
                AppTextStyles.buttonMedium,
                Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
