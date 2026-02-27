import 'package:flutter/material.dart';

import '../../../services/password_validator.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_input.dart';
import '../../../widgets/custom_text.dart';
import '../login_screen.dart';
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  bool _isValid = false;
  bool isReset = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validatePasswords);
    _confirmController.addListener(_validatePasswords);
  }

  void _validatePasswords() {
    final pass = _passwordController.text;
    final confirm = _confirmController.text;

    final isValid = PasswordValidator.arePasswordsValid(pass, confirm);

    if (isValid != _isValid) {
      setState(() => _isValid = isValid);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _onSubmit() async {
    if (!_isValid) {
      CustomAlertDialog.show(
        context,
        title: "Oups !",
        description:
        "Les mots de passe ne correspondent pas ou doivent contenir au moins 8 caractères, dont une majuscule et un chiffre.",
        confirmText: "D'accord",
        onConfirm: () {
          Navigator.pop(context);
        },
      );
      return;
    }


    setState(() => isReset = true);


    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;


    setState(() => isReset = false);


    CustomAlertDialog.show(
      context,
      title: "Réinitialisation !",
      description:
      "Votre mot de passe a été réinitialisé avec succès, vous pouvez vous reconnecter.",
      confirmText: "D'accord",
      onConfirm: () {
        Navigator.pop(context);

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      },
    );
  }

  void _cancelReset() {
    CustomAlertDialog.show(
      context,
      title: "Réinitialisation !",
      description: "Souhaitez-vous annuler la réinitialisation de votre mot de passe ?",
      confirmText: "Oui",
      cancelText: "Non",
      onConfirm: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onCancel: () {
        Navigator.pop(context);
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: AppColors.primary, size: 20),
          onPressed:   _cancelReset,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
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
                    CustomText.bold("Mot de passe",
                        size: 24, color: AppColors.primary),
                    const SizedBox(height: 4),
                    CustomText.regular(
                      "Veuillez créer un nouveau mot de passe",
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 17),
                    CustomInput(
                      controller: _passwordController,
                      label: "Nouveau mot de passe",
                      hint: "Nouveau mot de passe",
                      isPassword: true,
                    ),
                    const SizedBox(height: 17),
                    CustomInput(
                      controller: _confirmController,
                      label: "Confirmez nouveau mot de passe",
                      hint: "Confirmez nouveau mot de passe",
                      isPassword: true,
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: SafeArea(
                child: CustomButton(
                  isLoading: isReset,
                  text: "Réinitialiser",
                  onPressed: _onSubmit
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}