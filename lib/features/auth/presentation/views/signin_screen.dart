import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:ecommerce_app/core/validators/validetor_app.dart';
import 'package:ecommerce_app/core/view/main_screen.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_viewmodel.dart';
import 'package:ecommerce_app/features/auth/presentation/views/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authViewModel = Get.find<AuthViewModel>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 520.w,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    // Welcome title
                    Text(
                      easy.tr(LocaleKeys.auth_welcomeBack),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.heading1,
                        Theme.of(context).textTheme.bodyLarge?.color ??
                            AppColors.black,
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // Subtitle
                    Text(
                      easy.tr(LocaleKeys.auth_continueShopping),
                      textAlign: TextAlign.center,
                      style: AppTextStyles.withColor(
                        AppTextStyles.bodyMedium,
                        isDark
                            ? AppColors.grey400
                            : AppColors.grey600,
                      ),
                    ),

                    SizedBox(height: 40.h),

                    // Email
                    AppTextField(
                      label: easy.tr(LocaleKeys.auth_email),
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: ValidatorApp.validateEmail,
                    ),

                    SizedBox(height: 16.h),

                    // Password
                    AppTextField(
                      label: easy.tr(LocaleKeys.auth_password),
                      prefixIcon: Icons.lock_outlined,
                      keyboardType: TextInputType.text,
                      isPassword: true,
                      controller: _passwordController,
                      validator: ValidatorApp.validatePassword,
                    ),

                    SizedBox(height: 8.h),

                    // Forgot Password
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Get.off(() => ForgetPasswordScreen()),
                        child: Text(
                          easy.tr(LocaleKeys.auth_forgotPassword),
                          style: AppTextStyles.withColor(
                            AppTextStyles.bodyMedium,
                            Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child:  ElevatedButton(
                        onPressed:()=> _handleSignIn(context, authViewModel),
                        style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        )
                      ),
                    child: Text(
                      easy.tr(LocaleKeys.auth_signIn),
                      style: AppTextStyles.withColor(
                        AppTextStyles.buttonMedium, 
                        AppColors.white),
                    )),
                    ),
                    // Obx(() {
                    //   return AppButton(
                    //     label: easy.tr(LocaleKeys.auth_signIn),
                    //     isLoading: authViewModel.isLoading,
                    //     onPressed: () =>
                    //         _handleSignIn(context, authViewModel),
                    //   );
                    // }),

                    SizedBox(height: 16.h),

                    // Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            easy.tr(LocaleKeys.auth_dontHaveAccount),
                            textAlign: TextAlign.center,
                            style: AppTextStyles.withColor(
                              AppTextStyles.bodyMedium,
                              isDark
                                  ? AppColors.grey400
                                  : AppColors.grey600,
                            ),
                          ),
                        ),

                        TextButton(
                          onPressed: () {},
                          child: Text(
                            easy.tr(LocaleKeys.auth_signUp),
                            style: AppTextStyles.withColor(
                              AppTextStyles.bodyMedium,
                              Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Error Message
                    Obx(() {
                      if (authViewModel.errorMessage.isEmpty) {
                        return const SizedBox.shrink();
                      }

                      return Text(
                        authViewModel.errorMessage,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontSize: 14.sp,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleSignIn(BuildContext context,AuthViewModel authViewModel,) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await authViewModel.login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (authViewModel.isLoggedIn) {
      Get.offAll(() => const MainScreen());
    }
  }
}