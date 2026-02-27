import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:image_picker/image_picker.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../controller/contact_controller.dart';
import '../../models/contact.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_input.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_style.dart';
import '../../widgets/phone_input.dart';
import '../../widgets/extra_fields_modal.dart';

class CreateContactScreen extends StatefulWidget {
  const CreateContactScreen({super.key});

  @override
  State<CreateContactScreen> createState() => _CreateContactScreenState();
}

class _CreateContactScreenState extends State<CreateContactScreen> {
  final TextEditingController _nomController = TextEditingController( );
  final TextEditingController _prenomController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _entrepriseController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String _currentCountryCode = "CI";
  String _currentDialCode = "+225";

  final ContactController contactController =
      Get.find();

   final List<String> _selectedFields = [];


  void _addNewField(String fieldName) {
    setState(() {
      _selectedFields.add(fieldName);
    });
  }

  File? _selectedImage; // stocke l'image sélectionnée

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svg/back.svg', width: 12),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText.bold(
                      "Créer un contact",
                      size: 24,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 11),
                    CustomText.regular(
                      "Veuillez entrez les informations de contacts",
                      size: 16,
                      color: AppColors.grey,
                    ),

                    const SizedBox(height: 30),


                    Center(
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: _selectedImage != null
                            ? CircleAvatar(
                                radius: 90,
                                backgroundImage: FileImage(_selectedImage!),
                              )
                            : SvgPicture.asset(
                                "assets/svg/picPicture.svg",
                                width: 174,
                              ),
                      ),
                    ),
                    const SizedBox(height: 19),

                    CustomInput(
                      label: "Nom",
                      controller: _nomController,
                      hint: '',
                    ),
                    const SizedBox(height: 15),
                    CustomInput(
                      label: "Prénoms",
                      controller: _prenomController,
                      hint: '',
                    ),
                    const SizedBox(height: 15),
                    CustomInput(
                      label: "Entreprise",
                      controller: _entrepriseController,
                      hint: '',
                    ),
                    const SizedBox(height: 15),


                    PhoneInput(
                      label: "Téléphone",
                      controller: _phoneController,
                      onCountryChanged: (country) {
                        setState(() {
                          _currentCountryCode = country['code'] ?? "CI";
                          _currentDialCode = country['dialCode'] ?? "+225";
                        });
                      },
                    ),

                    const SizedBox(height: 19),

                    Row(
                      children: [
                        CustomText.bold(
                          "Ajouter un numéro",
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset('assets/svg/add.svg', width: 24),
                      ],
                    ),

                    const SizedBox(height: 19),

                    _buildOptionalField("Adresse mail", controller: _emailController),
                    const SizedBox(height: 15),
                    _buildOptionalField("Date d'anniversaire"),
                    const SizedBox(height: 15),
                    _buildOptionalField("Ajouter une adresse"),
                    ..._selectedFields
                        .map(
                          (field) => Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: _buildOptionalField(
                              field,
                              showRemoveIcon:
                                  true,
                              onRemove: () {
                                setState(() {
                                  _selectedFields.remove(
                                    field,
                                  );
                                });
                              },
                            ),
                          ),
                        )
                        .toList(),
                    const SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => ExtraFieldsModal.show(context, _addNewField),
                      child: Container(
                        width: double.infinity,
                        height: 59,
                        decoration: BoxDecoration(
                          color: AppColors.light,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CustomText.bold(
                            "Ajouter des champs supplémentaires",
                            size: 16,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: CustomButton(
                        text: "Ajouter le contact",
                        onPressed: () {

                          final nom = _nomController.text.trim();
                          final prenom = _prenomController.text.trim();
                          final phone = _phoneController.text.trim();


                          if (nom.isEmpty || prenom.isEmpty || phone.isEmpty) {

                            String message = "Veuillez renseigner :";
                            if (nom.isEmpty) message += "\n• Le nom";
                            if (prenom.isEmpty) message += "\n• Le prénom";
                            if (phone.isEmpty) message += "\n• Le numéro de téléphone";

                            CustomAlertDialog.show(
                              context,
                              title:  "Champs obligatoires",
                              description: message,
                              confirmText: "D'accord",
                              onConfirm: () => Navigator.pop(context),
                            );
                            return; // On bloque la suite
                          }

                          final newContact = ContactModel(
                            countryCode: _currentCountryCode,
                            dialCode: _currentDialCode,

                            email: _emailController.text,
                            firstName: _prenomController.text,
                            lastName: _nomController.text,
                            company: _entrepriseController.text,
                            phone: _phoneController.text,
                            image: _selectedImage,
                          );

                          contactController.addContact(newContact);
                          Get.back();
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionalField(
    String hint, {
    TextEditingController? controller,
    TextInputType keyboardType = TextInputType.text,
    bool showRemoveIcon = false,
    VoidCallback? onRemove,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: AppColors.light,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [

          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: CustomTextStyle.regular(
                size: 14,
                color: AppColors.primary,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: CustomTextStyle.regular(
                  size: 14,
                  color: AppColors.grey,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 15,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.primary,
                    width: 1.1,
                  ),
                ),
              ),
            ),
          ),


          if (showRemoveIcon)
            IconButton(
              onPressed: onRemove,
              icon: const Icon(
                Icons.remove_circle_outline,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
        ],
      ),
    );
  }
}
