import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:ecommerce_app/core/validators/validetor_app.dart';
import 'package:ecommerce_app/core/view/main_screen.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signin_screen.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(onPressed: ()=> Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: isDark? AppColors.white : AppColors.black,
                )),
                SizedBox(height: 20.h,),
                Text(
                  easy.tr(LocaleKeys.auth_createAccount,),
                  style: AppTextStyles.withColor(
                    AppTextStyles.heading1, 
                    Theme.of(context).textTheme.bodyLarge!.color!,
                    )
                  
                ),
                SizedBox(height: 8.h,),
                Text(
                  easy.tr(LocaleKeys.auth_signupToGetStarted,),
                  style: AppTextStyles.withColor(
                    AppTextStyles.heading1, 
                    isDark? AppColors.grey400 : AppColors.grey600,
                    )
                  
                ),
                SizedBox(height: 40.h,),
                AppTextField(
                  label: easy.tr(LocaleKeys.auth_fullName),
                  prefixIcon: Icons.person_outline,
                  keyboardType: TextInputType.name,
                  controller: _nameController,
                  validator: ValidatorApp.validateName,
                ),

                SizedBox(height: 16.h),

                AppTextField(
                  label: easy.tr(LocaleKeys.auth_email),
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  validator: ValidatorApp.validateEmail,
                ),

                SizedBox(height: 16.h),

                AppTextField(
                  label: easy.tr(LocaleKeys.auth_password),
                  prefixIcon: Icons.lock_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _passwordController,
                  validator: ValidatorApp.validatePassword,
                ),

                SizedBox(height: 16.h),

                AppTextField(
                  label: easy.tr(LocaleKeys.auth_confirmPassword),
                  prefixIcon: Icons.lock_outlined,
                  keyboardType: TextInputType.visiblePassword,
                  isPassword: true,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    return ValidatorApp.validateConfirmPassword(
                      value,
                      _passwordController.text,
                    );
                  },
                ),

                SizedBox(height: 24.h),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Get.off(() => MainScreen());
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      )
                    ),
                  child: Text(
                    easy.tr(LocaleKeys.auth_signUp),
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium, 
                      AppColors.white),
                  )),
                ),
                SizedBox(height: 24.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      easy.tr(LocaleKeys.auth_alreadyHaveAccount),
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonMedium, 
                        isDark? AppColors.grey400 : AppColors.grey600),
                    ),
                    TextButton(onPressed: ()=> Get.off(()=>SignInScreen()),
                    child: Text( easy.tr(LocaleKeys.auth_signIn),
                    style: AppTextStyles.withColor(
                      AppTextStyles.buttonMedium, 
                      Theme.of(context).primaryColor),
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}