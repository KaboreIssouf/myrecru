import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../widgets/custom_text_style.dart';

class ContactRecentScreen extends StatefulWidget {
  const ContactRecentScreen({super.key});

  @override
  State<ContactRecentScreen> createState() => _ContactRecentScreenState();
}
class _ContactRecentScreenState extends State<ContactRecentScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 31),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset('assets/logo/logoText.png', width: 102, height: 47),

              const SizedBox(height: 30),
               _buildSearchBar(),

              const SizedBox(height: 15),
              Spacer(),

              _buildEmptyState(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }





  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText.regular(
            "Aucun contacts récent",
            size: 18,
            color: Colors.black,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 25),
          SvgPicture.asset("assets/svg/alert.svg", width: 105),
        ],
      ),
    );
  }


  Widget _buildSearchBar() {
    return Container(
      height: 59,
      decoration: BoxDecoration(
        color: AppColors.secondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(


        decoration: InputDecoration(
          hintText: "Rechercher dans les contacts",
          hintStyle: CustomTextStyle.regular(size: 20, color: AppColors.primary),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset("assets/svg/search.svg", color: AppColors.primary),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}