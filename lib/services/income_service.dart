import 'dart:convert';

import 'package:expenze/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeService {
  // 1st STEP: define a key for store income to shared preferences
  static final String _incomeKey = "income";

  // 2nd STEP: save the income to shared preferences
  Future<void> saveIncome(Income income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      List<String>? existingIncomes = prefs.getStringList(_incomeKey);

      // 3rd STEP: converting the existing income to a list of income objects
      List<Income> existingIncomeObjects = [];
      if (existingIncomes != null) {
        existingIncomeObjects = existingIncomes
            .map((e) => Income.fromJASON(json.decode(e)))
            .toList();
      }
      // 4th STEP: add the new Income to the list
      existingIncomeObjects.add(income);

      // 5th STEP: convert list of Income object back to a list of strings
      List<String> updatedIncome =
          existingIncomeObjects.map((e) => json.encode(e.toJASON())).toList();

      // 6th STEP: save the updated list of income to shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      // 7th STEP: show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("ඔබගේ ආදායම් තොරතුර ඇතුලත් කර ගැනීම සාර්තකයි!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "ඔබගේ ආදය​ම් තොරතුර ඇතුලත් කර ගත නොහැක. නැවත උත්සහ කරන්න."),
            duration: Duration(minutes: 1),
          ),
        );
      }
    }
  }

  // 8th STEP: load the expenses from shared preferences
  Future<List<Income>> loadIncomes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingIncomes = pref.getStringList(_incomeKey);

    // 9th STEP: converting existing imcomes to a list of Income objects
    List<Income> loadedIncomes = [];
    if (existingIncomes != null) {
      loadedIncomes =
          existingIncomes.map((e) => Income.fromJASON(json.decode(e))).toList();
    }
    return loadedIncomes;
  }
// ------------ add page එකෙන් ආදායම් තොරතුරු ඉවත් කරනවා ------------- //

  // 1st - delete the expense from shared prefs from the id
  Future<void> deleteIncome(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exisitingIncomes = pref.getStringList(_incomeKey);

      // 2nd - convert the exisiting expenses to a list of expenses objects
      List<Income> exisitingIncomeObject = [];
      if (exisitingIncomes != null) {
        exisitingIncomeObject = exisitingIncomes
            .map(
              (e) => Income.fromJASON(json.decode(e)),
            )
            .toList();
      }
      // 3rd - remove the expense with the specified id from the list
      exisitingIncomeObject.removeWhere(
        (income) => income.id == id,
      );

      // 4th - convert the list of Expense objects back to a list of strings
      List<String> updatedIncome =
          exisitingIncomeObject.map((e) => json.encode(e.toJASON())).toList();

      // 5th - save the updated list of expenses to shared preferences
      await pref.setStringList(_incomeKey, updatedIncome);

      // show message (snackbar)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("ආදය​ම් තොරතුර ඉවත් කරන ලදි!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      // show message (snackbar)
      if (context.mounted) {
        print(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("ආදාය​ම් තොරතුර ඉවත් කිරීම අසාර්තකයි!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
  // delete all income from shared preferences
  Future<void> deleteAllIncome(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_incomeKey);
      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("සියලු​ම ආදාය​ම් තොරතුර ඉවත් කරන ලදි"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print(error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("සියලු​ම ආදාය​ම් තොරතු​රු ඉවත් කිරීම අසාර්තකයි!"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
