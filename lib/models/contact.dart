import 'dart:io';

class ContactModel {
  final String firstName;
  final String lastName;
  final String company;
  final String phone;
  final String? email;
  final File? image;

  final String countryCode;
  final String dialCode;

  ContactModel({
    required this.firstName,
    required this.lastName,
    required this.company,
    this.email = "",
    required this.phone,
    this.image,

    required this.countryCode,
    required this.dialCode,
  });
}