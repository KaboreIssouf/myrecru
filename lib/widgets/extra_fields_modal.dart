import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class ExtraFieldsModal extends StatelessWidget {
  final Function(String) onFieldSelected;

  const ExtraFieldsModal({super.key, required this.onFieldSelected});

  static void show(BuildContext context, Function(String) onFieldSelected) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ExtraFieldsModal(onFieldSelected: onFieldSelected),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [

        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(
            color: const Color(0xFFF8F8F8),
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),

              Container(
                width: 106,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 25),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText.bold(
                    "Sélectionner les champs\nà ajouter",
                    size: 24,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),


              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  children: [
                    _buildItem("Intitulé du poste", context),
                    _buildItem("Préfixe", context),
                    _buildItem("Suffixe", context),
                    _buildItem("Pseudo", context),
                    _buildItem("Classer en tant que", context),
                    _buildItem("Service", context),
                    _buildItem("Relations", context),
                    _buildItem("Site Web", context),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ),


        Positioned(
          top: -22,
          right: 25,
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 36,
              height: 35  ,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(String label, BuildContext context) {
    return GestureDetector(
      onTap: () {
        onFieldSelected(label);
        Navigator.pop(context);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomText.regular(label, size: 16, color: Colors.black),
      ),
    );
  }
}