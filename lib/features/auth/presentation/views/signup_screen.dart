import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:ecommerce_app/core/di/injection.dart';
import 'package:ecommerce_app/core/localization/locale_keys.g.dart';
import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:ecommerce_app/core/validators/validator_app.dart';
import 'package:ecommerce_app/core/view/main_screen.dart';
import 'package:ecommerce_app/core/widgets/app_button.dart';
import 'package:ecommerce_app/core/widgets/app_text_field.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:ecommerce_app/features/auth/presentation/viewmodels/auth_view_model.dart';
import 'package:ecommerce_app/features/auth/presentation/views/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authViewModel = getIt<AuthViewModel>();

    return BlocProvider.value(
      value: authViewModel.cubit,
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Get.off(() => const MainScreen());
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final errorMessage = state is AuthFailure ? state.message : '';

          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.h),
                child: Form(
                  key: _formKey,
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
                        easy.tr(LocaleKeys.auth_createAccount),
                        style: AppTextStyles.withColor(
                          AppTextStyles.heading1,
                          Theme.of(context).textTheme.bodyLarge!.color!,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        easy.tr(LocaleKeys.auth_signupToGetStarted),
                        style: AppTextStyles.withColor(
                          AppTextStyles.bodyMedium,
                          isDark ? AppColors.grey400 : AppColors.grey600,
                        ),
                      ),
                      SizedBox(height: 40.h),
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

                      AppButton(
                        label: easy.tr(LocaleKeys.auth_signUp),
                        isLoading: isLoading,
                        onPressed: () => _handleSignUp(authViewModel),
                      ),

                      SizedBox(height: 16.h),

                      if (errorMessage.isNotEmpty)
                        Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 14.sp,
                          ),
                        ),

                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            easy.tr(LocaleKeys.auth_alreadyHaveAccount),
                            style: AppTextStyles.withColor(
                              AppTextStyles.buttonMedium,
                              isDark ? AppColors.grey400 : AppColors.grey600,
                            ),
                          ),
                          TextButton(
                            onPressed: () => Get.off(() => SignInScreen()),
                            child: Text(
                              easy.tr(LocaleKeys.auth_signIn),
                              style: AppTextStyles.withColor(
                                AppTextStyles.buttonMedium,
                                Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _handleSignUp(AuthViewModel authViewModel) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    await authViewModel.signUp(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }
}
