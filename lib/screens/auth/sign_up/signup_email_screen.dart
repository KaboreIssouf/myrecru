import 'package:flutter/material.dart';
import 'package:myrecru/screens/auth/sign_up/signup_number_screen.dart';
import '../../../services/email_validator.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_text.dart';

class SignupEmailScreen extends StatefulWidget {
  final String lastName;
  final String firstName;
  const SignupEmailScreen({super.key, required this.lastName, required this.firstName});

  @override
  State<SignupEmailScreen> createState() => _SignupEmailScreenState();
}

class _SignupEmailScreenState extends State<SignupEmailScreen> {

  final TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onContinuePressed() async {
    if (_emailController.text.trim().isEmpty || !EmailValidator.isValid(_emailController.text.trim())) {
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
          builder: (context) => SignupNumberScreen(
            firstName:" _firstNameController.text.trim()",
            lastName: "_lastNameController.text.trim()",
          ),
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
                      CustomInput(
                        label: "Email",
                        hint: "ex : mail@gmail.com",
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
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
