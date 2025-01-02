import 'package:expenze/services/user_service.dart';
import 'package:expenze/widget/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: UserService.checkUsername(),
      builder: (context, snapshot) {
        // snappshot එක ඩේටා එනකම් බලා සිටී
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          // යූසර් නේම් එක තියෙනව නම් true නැත්නම් false
          bool hasUsename = snapshot.hasData ?? false;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Wrapper(
              showMainScreen: hasUsename,
            ),
          );
        }
      },
    );
  }
}
