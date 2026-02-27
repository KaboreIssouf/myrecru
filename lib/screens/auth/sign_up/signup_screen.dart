import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myrecru/screens/auth/sign_up/signup_email_screen.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_text.dart';
import '../login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {


  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  void _onContinuePressed() async {
    if (_firstNameController.text.trim().isEmpty ||
        _lastNameController.text.trim().isEmpty) {
      CustomAlertDialog.show(
        context,
        title: "Inscription",
        description: "Merci de renseigner votre nom et prénom pour continuer",
        confirmText: "D'accord",
        onConfirm: () {
          Navigator.pop(context);
        },
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignupEmailScreen(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
          ),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
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
                      Image.asset('assets/logo/logoText.png', height: 50),
                      const SizedBox(height: 44),
                      CustomText.bold("Inscription", size: 24, color: AppColors.primary),
                       const SizedBox(height: 15),
                      CustomText.regular(
                        "Veuillez entrez vos informations d’inscription",
                        size: 16,
                        color: AppColors.grey,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        label: "Nom",
                        hint: "ex : Kabore",
                        controller: _lastNameController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      CustomInput(
                        label: "Prénom",
                        hint: "ex : Issouf",
                        controller: _firstNameController,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CustomText.regular("Déjà un compte ? ", size: 13, color: Colors.black),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  LoginScreen())
                              );
                            },
                            child: CustomText.bold(
                              "Connectez-vous ici",
                              size: 13,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),
                      _socialButton("Se connecter avec", 'assets/svg/google.svg', () {
                        CustomAlertDialog.show(
                          context,
                          title: "Connexion Google",
                          description: "Bientôt disponible !",
                          confirmText: "D'accord",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        );
                      },),
                      const SizedBox(height: 12),
                      _socialButton("Se connecter avec", 'assets/svg/facebook.svg', () {
                        CustomAlertDialog.show(
                          context,
                          title: "Connexion Facebook",
                          description: "Bientôt disponible !",
                          confirmText: "D'accord",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                        );
                      },),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: CustomButton(
                  text: "Suivant",
                  onPressed: _onContinuePressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _socialButton(String text, String iconPath, VoidCallback onTap) {
    return Container(
      width: double.infinity,
      height: 59,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText.bold(
              text,
              size: 20,
              color: AppColors.primary,
            ),
            const SizedBox(width: 10),
            SvgPicture.asset(iconPath, width: 35),
          ],
        ),
      ),
    );
  }
}
