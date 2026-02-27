import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../controller/contact_controller.dart';
import '../../models/contact.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_style.dart';
import 'contact_detail_screen.dart';
import 'create_contact_screen.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({super.key});

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}
class _ContactListScreenState extends State<ContactListScreen> {

  final ContactController contactController = Get.put(ContactController());

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

              CustomButton(
                text: "Créer un contact",
                isOutlined: true,
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CreateContactScreen())
                ),
              ),

              const SizedBox(height: 20),


              Expanded(
                child: Obx(() {
                   final listToShow = contactController.filteredContacts;

                  if (listToShow.isEmpty) {
                     if (contactController.contacts.isNotEmpty && contactController.searchQuery.isNotEmpty) {
                      return _buildNoResultState();
                    }
                    return _buildEmptyState();
                  }

                  return ListView.builder(
                    itemCount: listToShow.length,
                    padding: const EdgeInsets.only(bottom: 20),
                    itemBuilder: (context, index) {
                      return _buildContactItem(listToShow[index]);
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoResultState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          const Icon(
            Icons.search_off_rounded,
            size: 80,
            color: Color(0xFFD9D9D9),
          ),
          const SizedBox(height: 20),
          CustomText.bold(
            "Aucun résultat",
            size: 18,
            color: Colors.black,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: CustomText.regular(
              "Nous n'avons trouvé aucun contacts correspondant à \"${contactController.searchQuery.value}\"",
              size: 14,
              color: AppColors.grey,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(ContactModel contact) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContactDetailScreen(contact: contact),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.light,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              backgroundImage: contact.image != null ? FileImage(contact.image!) : null,
              child: contact.image == null
                  ? const Icon(Icons.person, color: AppColors.primary)
                  : null,
            ),
            const SizedBox(width: 15),
            CustomText.regular(
              "${contact.firstName} ${contact.lastName}",
              size: 16,
              color: Colors.black,
            ),
          ],
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
            "Votre liste de\ncontacts est vide",
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

        onChanged: (value) => contactController.searchQuery.value = value,

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