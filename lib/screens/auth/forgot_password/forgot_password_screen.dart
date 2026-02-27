import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_text.dart';
import 'otp_verification_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final TextEditingController _phoneController =
  TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primary, size: 21),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 21),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomText.bold(
                      "Réinitialiser votre\nmot de passe",
                      size: 24,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 12),
                    CustomText.regular(
                      "Veuillez entrez votre numéro de téléphone pour réinitialiser votre mot de passe",
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 13),

                    CustomInput(
                      controller: _phoneController,
                      label: "Numéro de téléphone",
                      hint: "0123456789",
                      keyboardType: TextInputType.phone,
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                bottom:
                MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SafeArea(
                child: CustomButton(
                  text: "Suivant",
                  onPressed: () {
                    final phone = _phoneController.text.trim();

                    if (phone.isEmpty)
                      {
                        CustomAlertDialog.show(
                          context,
                          title: "Numéro",
                          description: "Merci de renseigner votre numéro de téléphone",
                          confirmText: "D'accorrd",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        );
                        return;
                      }


                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            OtpVerificationScreen(
                              phoneNumber: phone,
                            ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}