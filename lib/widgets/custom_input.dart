import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  const CustomInput({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: Stack(
        children: [
          TextField(
            controller: controller,
            obscureText: isPassword,
            keyboardType: keyboardType,
            cursorColor: AppColors.primary,
            textAlignVertical: TextAlignVertical.bottom,
            style: const TextStyle(fontFamily: 'Satoshi', fontSize: 20),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.3)),
              contentPadding: const EdgeInsets.fromLTRB(12, 36, 16, 5),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 10,
            child:
            CustomText.regular(label, size: 12, color: AppColors.grey,)
          ),
        ],
      ),
    );
  }
}