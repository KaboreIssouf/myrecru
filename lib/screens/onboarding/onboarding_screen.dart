import 'package:flutter/material.dart';
import 'package:myrecru/screens/auth/login_screen.dart';
import '../../../utils/app_colors.dart';
import '../../../widgets/custom_text.dart';
import '../../../widgets/custom_button.dart';
import '../../../models/onboarding_model.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;


  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: 'assets/onboarding/ob1.png',
      title: 'Le pouvoir de votre réseau, simplifié et centralisé.',
      description:
      'My Recrue vous permet de centraliser tous vos contacts en un seul endroit, pour un accès rapide et une gestion simplifiée.',
    ),

    OnboardingModel(
      image: 'assets/onboarding/ob2.png',
      title: 'Organisez et suivez vos opportunités efficacement.',
      description:
      'Classez vos contacts, ajoutez des notes et suivez chaque opportunité pour ne plus rien laisser au hasard.',
    ),

    OnboardingModel(
      image: 'assets/onboarding/ob3.png',
      title: 'Transformez vos contacts en véritables opportunités.',
      description:
      'Communiquez facilement, relancez au bon moment et développez votre réseau pour accélérer votre croissance.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return Padding(

                    padding: const EdgeInsets.symmetric(horizontal: 31),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText.bold( _pages[index].title, size: 30,  color: AppColors.primary, textAlign: TextAlign.left),
                        const SizedBox(height: 16),
                        CustomText.regular( _pages[index].description, size: 20,  color:Colors.black, textAlign: TextAlign.left),

                        const SizedBox(height: 95),
                        Center(
                          child: Image.asset(
                            _pages[index].image,
                            width: 265,
                            height: 243,
                            fit: BoxFit.contain,
                          ),
                        ),

                      ],
                    ),
                  );
                },
              ),
            ),


            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  CustomButton(
                    text: _currentIndex == _pages.length - 1 ? "Commencer" : "Suivant",
                    onPressed: () {
                      if (_currentIndex == _pages.length - 1) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  LoginScreen())
                        );
                      } else {
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 31),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pages.length, (index) => _buildDot(index)),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 2,
      width: _currentIndex == index ? 25 : 25,
      margin: const EdgeInsets.only(right: 17),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: _currentIndex == index ? AppColors.primary : AppColors.neutral.withOpacity(0.5),
      ),
    );
  }
}