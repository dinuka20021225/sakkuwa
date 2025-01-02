import 'package:expenze/screens/main_screen.dart';
import 'package:expenze/services/user_service.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  // for the check box
  bool _rememberMe = false;

  // formKey for form validation
  final _formKey = GlobalKey<FormState>();

  // controllers for text form fields
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // ඩිස්පෝස් එකෙන් වෙන්නේ ඊලග පිටුවකට යනකොට උඩ දීලා තියෙන කන්ට්‍රෝලස් වල මෙමරි එක අයින් වෙලා යන එ​ක
  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tnf.a f;dr;=re we;=,;a lrka​k",
                    style: TextStyle(
                      fontFamily: "title",
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        // ---- User Name Formfield ----//
                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(
                              10,
                            )
                          ],
                          controller: _userNameController,
                          validator: (value) {
                            // පරිශීලකයා යූසර් නේම් එක ඇතුලත් කලා ද කියා පරික්ශා කරයි.
                            if (value!.isEmpty) {
                              return "කරුණාකර ඔබගේ නම ඇතුලත් කරන්න.";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "Tnf.a uq,a k​u",
                            labelStyle: const TextStyle(
                              fontSize: 20,
                              fontFamily: "title",
                              color: darkGray,
                            ),
                            hintText:
                                "isxyf,ka fyda bx.%Sisfhka we;=,;a l, ye​l",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              fontFamily: "title",
                              color: darkGray,
                            ),
                          ),
                        ),
                        // ------------------------------------ //
                        const SizedBox(
                          height: 30,
                        ),
                        // -------------- Email Formfield -----------//
                        TextFormField(
                          controller: _emailController,
                          validator: (value) {
                            // පරිශීලකයා ඊ මේල් එක ඇතුලත් කලාද කියලා පරික්ශා කරයි.
                            if (value!.isEmpty) {
                              return "කරුණාකර ඔබගේ ඊමේල් එක ඇතුලත් කරන්න";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "Wnf.a Bfï,a tl we;=,;a lrka​​k",
                            labelStyle: const TextStyle(
                              fontSize: 19,
                              fontFamily: "title",
                              color: darkGray,
                            ),
                            hintText: "example@email.com",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: darkGray,
                            ),
                          ),
                        ),
                        // ------------------------------------ //
                        const SizedBox(
                          height: 30,
                        ),
                        // ------------- Password Formfield ------------//
                        TextFormField(
                          controller: _passwordController,
                          validator: (value) {
                            // පරිශීලකයා පාස්වර්ඩ් එක ඇතුලත් කලාද කියා පරික්ශා කරයි.
                            if (value!.isEmpty) {
                              return "කරුණාකර ඔබගේ මුරපද ඇතුලත් කරන්න";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "Wnf.a uqrmoh we;=,;a lrka​k",
                            labelStyle: const TextStyle(
                              fontSize: 19,
                              fontFamily: "title",
                              color: darkGray,
                            ),
                            hintText: "ex: SakkuWa1225&^£",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: darkGray,
                            ),
                          ),
                        ),
                        // ------------------------------------ //
                        const SizedBox(
                          height: 30,
                        ),
                        // ---- Confirm Password Formfield ----//
                        TextFormField(
                          controller: _confirmPasswordController,
                          validator: (value) {
                            // පරිශීලකයා නැවතත් පාස්වර්ඩ් එක ඇතුලත් කල තිබේදැයි පරික්ශා කර බලයි
                            if (value!.isEmpty) {
                              return "කරුණාකර ඔබගෙ පාස්වර්ඩ් එක නැවත ඇතුලත් කරන්න";
                            }
                            return null;
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.all(20),
                            labelText: "uqrmoh kej;​;a we;=,;a lrka​k",
                            labelStyle: const TextStyle(
                              fontSize: 19,
                              fontFamily: "title",
                              color: darkGray,
                            ),
                            hintText: "ex: SakkuWa1225&^£",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: darkGray,
                            ),
                          ),
                        ),
                        // ------------------------------------ //
                        const SizedBox(
                          height: 30,
                        ),
                        // --------- Remember me ----------//
                        Row(
                          children: [
                            const Text(
                              "f;dr;=re u;l ;nd .kak ",
                              style: TextStyle(
                                fontFamily: "title",
                                fontSize: 15,
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                activeColor: yellowColor,
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      _rememberMe = value!;
                                    },
                                  );
                                },
                              ),
                            ),
                            // ------------------------------------ //
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        // --------- submit button -----------//
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // ෆෝම් ෆීල්ඩ් ටි​ක වැලිඩ් නම් මේ ඩේටා ටික ප්‍රොසෙස් වෙනවා
                              String userName = _userNameController.text;
                              String email = _emailController.text;
                              String password = _passwordController.text;
                              String confirmPassword =
                                  _confirmPasswordController.text;

                              // යූසර් නේම් එකයි ඒමෙල් එක​යි phone storage එක සේව් කර ගන්නවා
                              await UserService.storeUserDetails(
                                userName: userName,
                                email: email,
                                password: password,
                                confirmPassword: confirmPassword,
                                context: context,
                              );

                              //Navigation to the main screen
                              if (context.mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) {
                                    return const MainScreen();
                                  }),
                                );
                              }
                            }
                          },
                          child: const CustomButton(
                            title: "bÈßh​g",
                            buttonColor: yellowColor,
                            titleColor: blackColor,
                          ),
                        ),
                        // ------------------------------------------ //
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
