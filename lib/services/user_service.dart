import 'package:expenze/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  // shared preferences වල යූසර්නේම් ඊමෙල් සේව් කර ගන්න මෙතඩ් එක
  static Future<void> storeUserDetails({
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
    required BuildContext context,
  }) async {
    // යූසර් එන්ටර් කරපු පාස්වර්ඩ් එකයි කන්ෆර්ම් පාස්වර්ඩ් එකයි සමානයි නම් යූසර්නේම් එකයි පාස්වර්ඩ් එකයි ගබඩා කර ගන්නවා
    try {
      // යූසර් එන්ටර් කරපු පාස්වර්ඩ් එකයි කන්ෆර්ම් පාස්වර්ඩ් එකයි සමානද කියා බලයි.
      if (password != confirmPassword) {
        // යූසර්​ට පොපඅප් මැසේජ් එකක් පෙන්වනවා පාස්වර්ඩ් සමාන නැත්තනම්.
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Tn we;=,;a l, uqrmoh iy kej; we;=,;a l, uqrmoh iudk ke​;",
              style: TextStyle(
                color: blackColor,
                fontFamily: "title",
              ),
            ),
            backgroundColor: yellowColor,
          ),
        );
        return;
      }
      //shared prefrence වල instence එකක් හදා ගන්නවා
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("username", userName);
      await prefs.setString("email", email);
      // යූසර්නේම් එකයි ඊමේල් එකයි සේව් කර ගත්තා කියලා යූසර්ට පෙන්නනවා
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Tnf.a f;dr;=re .nvd lr .ekSu id¾;l​hs",
            style: TextStyle(
              fontFamily: "title",
              color: blackColor,
            ),
          ),
          backgroundColor: yellowColor,
        ),
      );
    } catch (error) {
      error.toString();
    }
  }

  // shared preferences වල යූසර්නේම් එක සේව් වෙලාද කියලා බලන මෙතඩ් එක
  static Future<bool> checkUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("username");
    return userName != null;
  }

  // යූසර් නේම් එක මුල් පිටිවේ පෙන්වන මෙතඩ් එක ඒ එක්කම ඊ මේල් එකත් ගන්නවා
  static Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userName = prefs.getString("username");
    String? email = prefs.getString("email");

    // Handle null values gracefully
    return {
      "username": userName ?? "Guest",
      "email": email ?? "No email provided",
    };
  }

  static Future<String> username() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return username();
  }

  // removing user data (user name and email) from shared preferences
  static Future<void> clearUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('username');
    await pref.remove('email');
  }
}
