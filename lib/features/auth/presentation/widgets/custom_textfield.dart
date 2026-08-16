import 'package:ecommerce_app/core/utils/app_colors.dart';
import 'package:ecommerce_app/core/utils/app_textstyles.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String label;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  const CustomTextfield({
    super.key, 
    required this.label, 
    required this.prefixIcon, 
    this.keyboardType = TextInputType.text, 
    this.isPassword = false, 
    this.controller, 
    this.validator, 
    this.onChanged
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      onChanged: widget.onChanged,
      style: AppTextStyles.withColor(AppTextStyles.bodyMedium, 
        Theme.of( context).textTheme.bodyLarge!.color!
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: AppTextStyles.withColor(AppTextStyles.bodyMedium, 
          isDark ? AppColors.grey400 : AppColors.grey600
        ),
        prefixIcon: Icon(widget.prefixIcon,
          color: isDark ? AppColors.grey400 : AppColors.grey600,
        ),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: isDark ? AppColors.grey700 : AppColors.grey300,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: isDark ? AppColors.grey700 : AppColors.grey300,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
    );
  }
}
