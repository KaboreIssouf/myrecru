import 'package:get/get.dart';
import '../models/contact.dart';

class ContactController extends GetxController {
  var contacts = <ContactModel>[].obs;

  var searchQuery = "".obs;

  List<ContactModel> get filteredContacts {
    if (searchQuery.isEmpty) {
      return contacts;
    } else {
      return contacts.where((contact) {
        final fullName = "${contact.firstName} ${contact.lastName}"
            .toLowerCase();
        return fullName.contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }

  void addContact(ContactModel contact) {
    contacts.add(contact);
  }
}
