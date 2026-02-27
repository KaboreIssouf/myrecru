import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/app_colors.dart';
import 'custom_text_style.dart';

class PhoneInput extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool isValid;
  final Function(Map<String, String>) onCountryChanged;

  const PhoneInput({
    super.key,
    required this.label,
    required this.controller,
    this.isValid = false,
    required this.onCountryChanged,
  });

  @override
  State<PhoneInput> createState() => _PhoneInputState();
}

class _PhoneInputState extends State<PhoneInput> {
  final List<Map<String, String>> countries = [
    {'name': 'CI', 'code': '+225', 'flag': '🇨🇮'},
    {'name': 'SN', 'code': '+221', 'flag': '🇸🇳'},
    {'name': 'BF', 'code': '+226', 'flag': '🇧🇫'},
    {'name': 'ML', 'code': '+223', 'flag': '🇲🇱'},
    {'name': 'GH', 'code': '+233', 'flag': '🇬🇭'},
    {'name': 'NG', 'code': '+234', 'flag': '🇳🇬'},
  ];

  late Map<String, String> selectedCountry;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    selectedCountry = countries[0];


    widget.controller.addListener(_validateNumber);
  }

  void _validateNumber() {
    final text = widget.controller.text;
    if (text.isEmpty) {
      setState(() => _isValid = false);
      return;
    }
    final isValid = RegExp(r'^\d{8,10}$').hasMatch(text);
    setState(() => _isValid = isValid);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_validateNumber);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 59,
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controller,
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.primary,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            textAlignVertical: TextAlignVertical.bottom,
            style: CustomTextStyle.regular(size: 16) ,
            decoration: InputDecoration(
              isDense: true,
              hintText: " 07 58 15 15 22",
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),

              contentPadding: const EdgeInsets.fromLTRB(85, 31, 16, 8),

              suffixIcon: widget.controller.text.isEmpty
                  ? null
                  : Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(right: 8),
                child: Icon(
                  Icons.check_circle,
                  color: _isValid ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
            ),
          ),


          Positioned(
            left: 14,
            top: 24,
            child: GestureDetector(
              onTap: _showCountryPicker,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(selectedCountry['flag']!, style: const TextStyle(fontSize: 20)),
                  const SizedBox(width: 8),
                  Text(
                    selectedCountry['code']!,
                    style: CustomTextStyle.regular(size: 16)
                  ),
                  // La flèche a été retirée ici
                ],
              ),
            ),
          ),

          // LE LABEL
          Positioned(
            left: 16,
            top: 10,
            child: Text(
              widget.label,
              style: CustomTextStyle.regular(size: 12,  color: AppColors.grey)
            ),
          ),
        ],
      ),
    );
  }

  void _showCountryPicker() {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView(
          shrinkWrap: true,
          children: countries.map((c) => ListTile(
            leading: Text(c['flag']!, style: const TextStyle(fontSize: 24)),
            title: Text("${c['name']} (${c['code']})",
                style: const TextStyle(fontFamily: 'Satoshi', fontWeight: FontWeight.w500)),
            onTap: () {
              setState(() => selectedCountry = c);
              widget.onCountryChanged(c);
              Navigator.pop(context);
            },
          )).toList(),
        ),
      ),
    );
  }
}