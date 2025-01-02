import 'package:expenze/data/onboarding_data.dart';
import 'package:expenze/screens/details_page.dart';
import 'package:expenze/screens/onboarding/onboarding1.dart';
import 'package:expenze/screens/onboarding/shared_onboarding_screen.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //---- indicator count ----//
  final PageController _controller = PageController();
  bool showDetailsPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              yellowColor,
              whiteColor,
            ],
            radius: 1.8,
            center: Alignment.topLeft,
            // begin: Alignment.topLeft,
            // end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 20,
                      ),
                      child: PageView(
                        controller: _controller,
                        onPageChanged: (value) {
                          setState(() {
                            showDetailsPage = value == 3;
                          });
                        },
                        children: [
                          Onboarding1(),
                          SharedOnboardingScreen(
                            image: OnboardingData.onboardingData[0].image,
                            title: OnboardingData.onboardingData[0].title,
                            description:
                                OnboardingData.onboardingData[0].description,
                          ),
                          SharedOnboardingScreen(
                            image: OnboardingData.onboardingData[1].image,
                            title: OnboardingData.onboardingData[1].title,
                            description:
                                OnboardingData.onboardingData[1].description,
                          ),
                          SharedOnboardingScreen(
                            image: OnboardingData.onboardingData[2].image,
                            title: OnboardingData.onboardingData[2].title,
                            description:
                                OnboardingData.onboardingData[2].description,
                          ),
                        ],
                      ),
                    ),
                    // ------ Page Dot Indicators -------//
                    Container(
                      alignment: Alignment(0, 0.65),
                      child: SmoothPageIndicator(
                        controller: _controller,
                        count: 4,
                        effect: WormEffect(
                          activeDotColor: yellowColor,
                          dotColor: grayColor,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 40,
                      left: 0,
                      right: 0,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: !showDetailsPage
                              ? GestureDetector(
                                  onTap: () {
                                    _controller.animateToPage(
                                        _controller.page!.toInt() + 1,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.easeInCirc);
                                  },
                                  child: CustomButton(
                                    title: showDetailsPage
                                        ? "wdrun lrkak"
                                        : "bÈßhg",
                                    buttonColor: yellowColor,
                                    titleColor: blackColor,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailsPage(),
                                      ),
                                    );
                                  },
                                  child: CustomButton(
                                    title: showDetailsPage
                                        ? "wdrun lrkak"
                                        : "bÈßhg",
                                    buttonColor: yellowColor,
                                    titleColor: blackColor,
                                  ),
                                )),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
