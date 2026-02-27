import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? outlineColor;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.outlineColor,
    this.width = double.infinity,
    this.height = 55,
    this.backgroundColor = AppColors.primary,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveOutlineColor = outlineColor ?? AppColors.primary;

    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: isOutlined ? Colors.transparent : backgroundColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: isLoading ? null : onPressed,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: isOutlined
                  ? Border.all(color: effectiveOutlineColor, width: 1)
                  : null,
              borderRadius: BorderRadius.circular(10),
            ),
            child: isLoading
                ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(
                  isOutlined ? effectiveOutlineColor : textColor,
                ),
              ),
            )
                : CustomText.bold(
              text,
              color: isOutlined ? effectiveOutlineColor : textColor,
              size: 16,
            ),
          ),
        ),
      ),
    );
  }
}