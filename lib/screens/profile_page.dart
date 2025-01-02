import 'package:expenze/screens/onboarding_screen.dart';
import 'package:expenze/services/expense_service.dart';
import 'package:expenze/services/income_service.dart';
import 'package:expenze/services/user_service.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "";
  String email = "";

  @override
  void initState() {
    UserService.getUserData().then(
      (value) {
        if (value['username'] != null && value['email'] != null) {
          setState(() {
            userName = value['username']!;
            email = value['email']!;
          });
        }
      },
    );
    super.initState();
  }

  // scaffold messenger for showing logout
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      backgroundColor: whiteColor,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "ඉවත්වීම තහවුරු කරනවද?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellowColor,
                    ),
                    onPressed: () async {
                      // clear the user data
                      await UserService.clearUserData();
                      // clear all expenses and income
                      if (context.mounted) {
                        await ExpenseService().deleteAllExpenses(context);
                        await IncomeService().deleteAllIncome(context);
                      }
                      // navigate to the onboarding screen
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      "ඔ​ව්",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: yellowColor,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      "නැ​ත",
                      style: TextStyle(
                        color: blackColor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      AnimationConfiguration.staggeredList(
                        position: 0,
                        duration: const Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: blackColor,
                                      width: 3,
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        "assets/images/dinuka.jpg",
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Welcome $userName",
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    Text(
                                      email,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Inter",
                                        color: darkGray,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                const Spacer(),
                                const FaIcon(FontAwesomeIcons.edit)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                AnimationLimiter(
                  child: Column(
                    children: [
                      // Animated ProfileCards
                      const AnimationConfiguration.staggeredList(
                        position: 1,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ProfileCard(
                              icon: FontAwesomeIcons.wallet,
                              title: "පසුම්බි​ය",
                              color: yellowColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const AnimationConfiguration.staggeredList(
                        position: 2,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ProfileCard(
                              icon: FontAwesomeIcons.gear,
                              title: "සැකසීම",
                              color: yellowColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const AnimationConfiguration.staggeredList(
                        position: 3,
                        duration: Duration(milliseconds: 500),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: ProfileCard(
                              icon: FontAwesomeIcons.download,
                              title: "දත්ත බාගත කරගන්න",
                              color: yellowColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: () {
                          _showBottomSheet(context);
                        },
                        child: const AnimationConfiguration.staggeredList(
                          position: 4,
                          duration: Duration(milliseconds: 500),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: ProfileCard(
                                icon: FontAwesomeIcons.rightFromBracket,
                                title: "ඉවත් වන්න",
                                color: yellowColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
