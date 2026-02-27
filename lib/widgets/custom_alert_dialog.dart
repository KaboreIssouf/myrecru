import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';
import 'custom_button.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String description;
  final String confirmText;
  final String? cancelText;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.description,
    this.confirmText = "Confirmer",
    this.cancelText = "Annuler",
    required this.onConfirm,
      this.onCancel,
  });


  static void show(
      BuildContext context, {
        required String title,
        required String description,
        String confirmText = "Confirmer",
        String? cancelText,
        required VoidCallback onConfirm,
          VoidCallback? onCancel,
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => CustomAlertDialog(
        title: title,
        description: description,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText.bold(
              title,
              size: 24,
              color: AppColors.primary,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CustomText.regular(
              description,
              size: 16,
              color: Colors.black,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: confirmText,
              onPressed: onConfirm,
              height: 50,
            ),
            if (cancelText != null) ...[
              const SizedBox(height: 12),
              CustomButton(
                text: cancelText!,
                onPressed: onCancel,
                isOutlined: true,
                outlineColor: AppColors.primary,
                height: 50,
              ),
            ],
          ],
        ),
      ),
    );
  }
}