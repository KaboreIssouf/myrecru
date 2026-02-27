import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myrecru/screens/auth/sign_up/signup_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_button.dart';
import '../../services/email_validator.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_input.dart';
import '../home/home_screen.dart';
import 'forgot_password/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

   final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
       CustomAlertDialog.show(
        context,
        title: "Champs requis",
        description: "Veuillez remplir votre identifiant et votre mot de passe.",
        confirmText: "D'accord",
        onConfirm: () => Navigator.pop(context),
      );
      return;
    }

    if (!EmailValidator.isValid(email)) {
      CustomAlertDialog.show(
        context,
        title: "Email invalide",
        description: "Veuillez renseigner une adresse email valide.",
        confirmText: "D'accord",
        onConfirm: () => Navigator.pop(context),
      );
      return;
    }

     setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() => _isLoading = false);

    CustomAlertDialog.show(
      context,
      title: "Bienvenue",
      description: "Vous êtes connecté avec succès.",
      confirmText: "Continuer",
      onConfirm: () {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
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
                        CustomText.bold("Connexion", size: 24, color: AppColors.primary),
                         const SizedBox(height: 15),
                        CustomText.regular(
                          "Veuillez entrez vos informations de connexion",
                          size: 16,
                          color: AppColors.grey,
                        ),
                        const SizedBox(height: 20),
                        CustomInput(
                          label: "Identifiant",
                          hint: "ex : mail@gmail.com",
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),
                        CustomInput(
                          label: "Mot de passe",
                          hint: "••••••",
                          isPassword: true,
                          controller: _passwordController,
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            CustomText.regular("Mot de passe oublié ? ", size: 13, color: Colors.black),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  ForgotPasswordScreen())
                                );
                              },
                              child: CustomText.bold(
                                "Cliquez ici",
                                size: 13,
                                color: AppColors.primary,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 7),
                        Row(
                          children: [
                            CustomText.regular("Pas encore de compte ? ", size: 13, color: Colors.black),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) =>  SignupScreen())
                                );
                              },
                              child: CustomText.bold(
                                "Inscrivez-vous ici",
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
                    text: "Connecter",
                    isLoading: _isLoading,
                    onPressed: _onLoginPressed,
                  ),
                ),
              ],
            ),
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
