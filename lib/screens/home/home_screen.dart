
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myrecru/screens/qr_code/scan_qr_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../contacts/create_contact_screen.dart';
import 'home_tabs_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
    canPop: false,
    onPopInvokedWithResult: (didPop, result) async {
      if (didPop) return;

      CustomAlertDialog.show(
        context,
        title: "Quitter",
        description: "Voulez-vous vraiment quitter ?",
        confirmText: "Quitter",
        cancelText: "Rester",
        onCancel: ()
        {
          Navigator.pop(context);
        },
        onConfirm: () {
          SystemNavigator.pop();
        },
      );
    },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu_rounded, color: AppColors.primary, size: 28),
                    Image.asset('assets/logo/logoLetter.png', height: 39),
                    const CircleAvatar(
                      radius: 22,
                      backgroundImage: AssetImage('assets/images/userPic.png'),
                    ),
                  ],
                ),

                const SizedBox(height: 35),

                CustomText.bold("Bonjour Christian,", size: 24, color: AppColors.primary),
                const SizedBox(height: 8),
                CustomText.regular(
                  "Bienvenue dans votre outil de gestion\ndes contacts",
                  size: 20,
                  color: Colors.black,
                ),

                const SizedBox(height: 30),

                _buildBanner(),

                const SizedBox(height: 25),

                _buildActionCard(
                  title: "Scanner le code QR\npour ajouter un contacts",
                  iconPath: "assets/svg/qrCode.svg",
                  isOutlined: true,
                  onTap: ()
                    {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ScanQRScreen()),
                      );
                    }
                ),
                const SizedBox(height: 15),
                _buildActionCard(
                  title: "Voir la liste des contacts",
                  iconPath: "assets/svg/arrow.svg",
                  iconSize: 24,
                  backgroundColor: const Color(0xFFF2EDED),
                  titleColor: AppColors.primary,
                    onTap: ()
                    {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomeTabsScreen()),
                      );
                    }
                ),
                const SizedBox(height: 15),
                _buildActionCard(
                  title: "Créer un contact",
                  iconPath: "assets/svg/contacts.svg",
                  backgroundColor: AppColors.primary,
                  svgColor: Colors.white,
                  titleColor: Colors.white,
                  isFull: true,
                  onTap: ()
                    {
                    Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreateContactScreen()));

                    }
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildBanner() {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/illustration.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black.withOpacity(0.7), Colors.transparent],
          ),
        ),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.bottomLeft,
        child:   CustomText.bold(
            "Le pouvoir de votre\nréseau, simplifié et\ncentralisé.",
            size: 24, color: Colors.white),
      ),
    );
  }


  Widget _buildActionCard({
    required String title,
    required String iconPath,
    double iconSize = 45,
    Color svgColor = AppColors.primary,
    Color backgroundColor = Colors.white,
    Color titleColor = AppColors.primary,
    bool isOutlined = false,
    bool isFull = false,
    VoidCallback? onTap,
    bool isClickable = true,
  }) {
    return GestureDetector(
      onTap: isClickable ? onTap : null,
      child: Container(
        width: double.infinity,
        height: 92,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(15),
          border: isOutlined ? Border.all(color: AppColors.primary, width: 1.2) : null,
        ),
        child: Row(
          children: [

            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText.regular(
                  title,
                  size: 20,
                  color: titleColor,
                 ),
              ),
            ),
            const SizedBox(width: 10),

            Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(
                iconPath,
                width: iconSize,
                height: iconSize,
                color: svgColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}