import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/app_colors.dart';
import 'custom_text.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF4EFF1),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem("assets/svg/heart.svg", "Favoris", 0),
          _navItem("assets/svg/time.svg", "Récent", 1),
          _navItem("assets/svg/contact.svg", "Contact", 2),
        ],
      ),
    );
  }
 
  Widget _navItem(String iconPath, String label, int index) {
    final bool isSelected = index == selectedIndex;
    final color = isSelected ? AppColors.primary : Colors.black;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            color: color,
          ),
          const SizedBox(height: 4),
          CustomText.bold(
            label,
            size: 16,
            color: color,
          ),
        ],
      ),
    );
  }
}