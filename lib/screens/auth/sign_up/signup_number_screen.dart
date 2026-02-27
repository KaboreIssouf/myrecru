import 'package:flutter/material.dart';
import 'package:myrecru/screens/auth/sign_up/signup_picture_screen.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/phone_input.dart';

class SignupNumberScreen extends StatefulWidget {
  final String lastName;
  final String firstName;
  const SignupNumberScreen({super.key, required this.lastName, required this.firstName});

  @override
  State<SignupNumberScreen> createState() => _SignupNumberScreenState();
}

class _SignupNumberScreenState extends State<SignupNumberScreen> {


  final TextEditingController _phoneController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinuePressed() async {
    if (_phoneController.text.trim().isEmpty) {
      CustomAlertDialog.show(
        context,
        title: "Inscription",
        description: "Merci de renseigner un email valide",
        confirmText: "D'accord",
        onConfirm: () => Navigator.pop(context),
      );
      return;
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupPictureScreen(),
        ),
      );
    }
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText.bold("Inscription", size: 24, color: AppColors.primary),
                      const SizedBox(height: 15),
                      CustomText.regular(
                        "Veuillez entrez vos informations d’inscription",
                        size: 16,
                        color: AppColors.grey,
                      ),
                      const SizedBox(height: 20),

                      PhoneInput(
                        label: "Numéro de téléphone",
                        controller: _phoneController,
                        isValid: _phoneController.text.length >= 10,
                        onCountryChanged: (country) {
                          print("Code sélectionné : ${country['code']}");
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: "Suivant",
                  isLoading: _isLoading,
                  onPressed: _onContinuePressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
