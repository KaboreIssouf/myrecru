import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/contact.dart';
import '../utils/app_colors.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class ShareContactDialog extends StatefulWidget {
  final ContactModel contact;

  const ShareContactDialog({super.key, required this.contact});

  @override
  State<ShareContactDialog> createState() => _ShareContactDialogState();
}

class _ShareContactDialogState extends State<ShareContactDialog> {

  bool showShareMethods = false;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            CustomText.bold("Partager le contacts", size: 24, color: AppColors.primary),
            const SizedBox(height: 12),
            CustomText.bold("${widget.contact.firstName} ${widget.contact.lastName}",
                size: 16, color: AppColors.grey),
            const SizedBox(height: 7),

            CustomText.light("Téléphone", size: 16, color: AppColors.grey),

            Row(
              children: [

                Container(
                  width: 16,
                  height: 14,
                  child: CountryFlag.fromCountryCode(
                    widget.contact.countryCode,
                  ),
                ),
                const SizedBox(width: 10),
                CustomText.bold(
                    "${widget.contact.dialCode} ${widget.contact.phone}",
                    size: 14,
                    color: AppColors.grey
                ),
              ],
            ),

             if (showShareMethods) ...[
              const SizedBox(height: 27),
               SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildShareIcon("assets/svg/facebook.svg"),
                    const SizedBox(width: 7),
                    _buildShareIcon("assets/contact/messenger.svg"),
                    const SizedBox(width: 7),
                    _buildShareIcon("assets/contact/whatsapp.svg"),
                    const SizedBox(width: 7),
                    _buildShareContact("assets/contact/c1.png"),
                    const SizedBox(width: 7),
                    _buildShareContact("assets/contact/c2.png"),
                    const SizedBox(width: 7),
                    _buildShareIcon("assets/contact/contact3.svg"),
                    const SizedBox(width: 7),
                    _buildShareIcon("assets/contact/contact4.svg"),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 9),

             if(!showShareMethods) ...[
            SizedBox(
              width: double.infinity,
              child:  CustomButton(
                text:  "Continuer",
                onPressed: () {
                  if (!showShareMethods) {
                    setState(() => showShareMethods = true);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            ],
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.primary.withOpacity(0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: CustomText.bold("Annuler", color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareIcon(String path) {
    return SvgPicture.asset(path, width: 37);
  }
  Widget _buildShareContact(String path) {
    return Image.asset(path, width: 37);
  }
}