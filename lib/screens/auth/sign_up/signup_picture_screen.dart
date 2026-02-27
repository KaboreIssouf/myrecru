import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';
import '../login_screen.dart';

class SignupPictureScreen extends StatefulWidget {
  const SignupPictureScreen({super.key});

  @override
  State<SignupPictureScreen> createState() => _SignupPictureScreenState();
}

class _SignupPictureScreenState extends State<SignupPictureScreen> {
  bool _isLoading = false;
  File? _selectedImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  void _onSuivantPressed() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) setState(() => _isLoading = false);


    CustomAlertDialog.show(
      context,
      title: "Création de compte",
      description:
      "Compte crée avec succès, vous pouvez vous connecter.",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.bold("Inscription", size: 28, color: AppColors.primary),
              const SizedBox(height: 12),
              CustomText.regular(
                "Veuillez entrez vos informations d’inscription",
                size: 16,
                color: Colors.black,
              ),
              const SizedBox(height: 8),
              CustomText.regular("Télécharger une photo", size: 14, color: AppColors.primary),
              const Spacer(flex: 1),


              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: _selectedImage != null
                      ? CircleAvatar(
                    radius: 112,
                    backgroundImage: FileImage(_selectedImage!),
                  )
                      : SvgPicture.asset(
                    "assets/svg/picPicture.svg",
                    width: 225,
                  ),
                ),
              ),

              const Spacer(flex: 2),


              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: CustomButton(
                  text:   "Ignorer",
                  onPressed: () {},
                  isOutlined: true,

                ),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 25),
                child: CustomButton(
                  text: "S'inscrire",
                  isLoading: _isLoading,
                  onPressed: _onSuivantPressed,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}