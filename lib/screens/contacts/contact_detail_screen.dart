
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../models/contact.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/share_contact_dialog.dart';

class ContactDetailScreen extends StatelessWidget {
  final ContactModel contact;

  const ContactDetailScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [

          Stack(
            children: [

              Container(
                height: MediaQuery.of(context).size.height * 0.45,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: contact.image != null
                      ? DecorationImage(image: FileImage(contact.image!), fit: BoxFit.cover)
                      : null,
                  color: AppColors.grey.withOpacity(0.2),
                ),
                child: contact.image == null
                    ? const Icon(Icons.person, size: 100, color: Colors.white)
                    : null,
              ),


              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25, 40, 25, 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.5),
                          ],
                        ),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),

                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText.bold(
                            "${contact.firstName} ${contact.lastName}",
                            size: 24,
                            color: AppColors.primary,
                          ),
                          CustomText.regular(

                            contact.company.isNotEmpty ? contact.company : "Particulier",
                            size: 16,
                            color: AppColors.primary.withOpacity(0.8),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),


              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCircleButton("assets/svg/back.svg", size: 12,() => Navigator.pop(context)),

                      _buildCircleButton("assets/svg/camera.svg", hasShadow: true,size: 39,() {}),
                     ],
                  ),
                ),
              ),
            ],
          ),


          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: _buildInfoCard("Téléphone", contact.phone),
                      ),
                      const SizedBox(width: 12),
                      _buildActionButtons(contact.phone),
                    ],
                  ),
                  const SizedBox(height: 15),


                  _buildInfoCard(
                      "Adresse email",
                      (contact.email != null && contact.email!.isNotEmpty)
                          ? contact.email!
                          : "non renseignée",
                      svgAsset: "assets/svg/mail.svg"
                  ),
                  const SizedBox(height: 13),


                  _buildMenuTile(
                      "Partager le contacts",
                      "assets/svg/share.svg",
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: true, // Permet de fermer en cliquant à côté
                        builder: (context) => ShareContactDialog(contact: contact),
                      );
                    },
                  ),
                  const SizedBox(height: 13),


                  _buildMenuTile(
                      "Supprimer le contacts",
                      "assets/svg/delete.svg",
onTap: ()
                      {
                        CustomAlertDialog.show(
                          context,
                          title: "Placer dans la corbeille ?",
                          description: "Ce contacts sera supprimé de tous vos appareils synchronisés",
                          confirmText: "Placer dans la corbeille",
                          cancelText: "Annuler",
                          onConfirm: () {
                            Navigator.pop(context);
                          },
                          onCancel: () {
                            Navigator.pop(context);
                          },
                        );
                      }
                  ),                ],
              ),
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildCircleButton(String svgAsset, VoidCallback onTap, {double size = 20, bool hasShadow = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 31),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: hasShadow
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ]
              : null,
        ),
        child: SvgPicture.asset(
          svgAsset,
          width: size,
        ),
      ),
    );
  }

   Widget _buildInfoCard(String label, String value, {String? svgAsset}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F8F8),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText.regular(label, size: 12, color: AppColors.grey),
              const SizedBox(height: 4),
              CustomText.bold(value, size: 16, color: Colors.black87),
            ],
          ),
          if (svgAsset != null)
            SvgPicture.asset(svgAsset, color: AppColors.primary, width: 22),
        ],
      ),
    );
  }

   Widget _buildMenuTile(String title, String svgPath, {VoidCallback? onTap, bool isDestructive = false}) {
     final color = isDestructive ? Colors.red : AppColors.primary;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText.bold(title, size: 16, color: color),
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              width: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(String phoneNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          GestureDetector(
            onTap: () async {
              try {
                final Uri smsUri = Uri(
                  scheme: 'sms',
                  path: phoneNumber,
                );

                await launchUrl(
                  smsUri,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                debugPrint("Erreur ouverture SMS: $e");
              }
            },
            child: SvgPicture.asset(
              "assets/svg/sms.svg",
              color: Colors.white,
              width: 22,
            ),
          ),

          const SizedBox(width: 20),


          GestureDetector(
            onTap: () async {
              try {
                final Uri telUri = Uri(
                  scheme: 'tel',
                  path: phoneNumber,
                );

                await launchUrl(
                  telUri,
                  mode: LaunchMode.externalApplication,
                );
              } catch (e) {
                debugPrint("Erreur ouverture appel: $e");
              }
            },
            child: SvgPicture.asset(
              "assets/svg/call.svg",
              color: Colors.white,
              width: 22,
            ),
          ),
        ],
      ),
    );
  }

}