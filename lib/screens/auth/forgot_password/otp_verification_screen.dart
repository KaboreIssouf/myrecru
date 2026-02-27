import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myrecru/screens/auth/forgot_password/reset_password_screen.dart';

import '../../../utils/app_colors.dart';
import '../../../widgets/custom_alert_dialog.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  int _start = 10;
  Timer? _timer;

  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() => _start--);
      }
    });
  }

  bool get _isOtpComplete => _controllers.every((c) => c.text.length == 1);

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.length == 1 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    CustomText.bold(
                      "Code OTP",
                      size: 24,
                      color: AppColors.primary,
                    ),
                    const SizedBox(height: 12),
                    CustomText.regular(
                      "Vous avez reçu un code de réactivation par sms",
                      size: 16,
                      color: AppColors.grey,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        4,
                        (index) => _buildOtpBox(index),
                      ),
                    ),

                    const SizedBox(height: 20),

                    CustomText.regular(
                      "00 : ${_start.toString().padLeft(2, '0')} secondes",
                      size: 14,
                      color: Colors.black,
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: [
                        CustomText.regular(
                          "Pas encore reçu ? ",
                          size: 14,
                          color: Colors.black,
                        ),
                        GestureDetector(
                          onTap: _start == 0
                              ? () {
                                  setState(() => _start = 10);
                                  startTimer();
                                }
                              : null,
                          child: CustomText.bold(
                            "Renvoyez",
                            size: 14,
                            color: _start == 0 ? AppColors.primary : AppColors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),


            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 20,
              ),
              child: SafeArea(
                child: CustomButton(
                  text: "Suivant",
                  onPressed: _isOtpComplete
                      ? () {
                          final otp = _controllers.map((e) => e.text).join();
                          print("OTP : $otp");

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ResetPasswordScreen(),
                            ),
                          );
                        }
                      :  () {   CustomAlertDialog.show(
                    context,
                    title: "Code OTP",
                    description: "Merci de renseigner le code OTP reçu sur le ${widget.phoneNumber}",
                    confirmText: "D'accorrd",
                    onConfirm: () {
                      Navigator.pop(context);
                    },
                  ); }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 65,
      height: 65,
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // ← autorise seulement les chiffres
        ],
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
        decoration: InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300, width: 2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
        ),
        onChanged: (value) => _onOtpChanged(value, index),
      ),
    );
  }
}
