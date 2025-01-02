import 'dart:convert';

import 'package:expenze/models/expens_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseService {
  // define a key store expenses in shared preferences
  static final String _expensekey = "expenses";

  // save the expense to shared preferences
  Future<void> saveExpenses(Expense expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingExpenses = prefs.getStringList(_expensekey);

      // converting the existing expense to a list of expenses object
      List<Expense> existingExpensesObjects = [];
      if (existingExpenses != null) {
        existingExpensesObjects = existingExpenses
            .map((e) => Expense.fromJSON(json.decode(e)))
            .toList();
      }

      // add the new expense to the list
      existingExpensesObjects.add(expense);

      // convert list of Expense object back to a list of strings
      List<String> updatedExpenses =
          existingExpensesObjects.map((e) => json.encode(e.toJASON())).toList();

      // save the updated list of expenses to shared preferences
      await prefs.setStringList(_expensekey, updatedExpenses);

      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("ඔබගේ වියදම් තොරතුර ඇතුලත් කර ගැනීම සාර්තකයි!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      // show error message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                "ඔබගේ වියදම් තොරතුර ඇතුලත් කර ගත නොහැක. නැවත උත්සහ කරන්න."),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  // load the expenses from shared preferences
  Future<List<Expense>> loadExpenses() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? existingExpenses = pref.getStringList(_expensekey);

    // converting existing expenses to a list of Expense objects
    List<Expense> loadedExpenses = [];
    if (existingExpenses != null) {
      loadedExpenses = existingExpenses
          .map((e) => Expense.fromJSON(json.decode(e)))
          .toList();
    }
    return loadedExpenses;
  }

// ------------ add page එකෙන් වියදම් තොරතුරු ඉවත් කරනවා ------------- //

  // 1st - delete the expense from shared prefs from the id
  Future<void> deleteExpense(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exisitingExpenses = pref.getStringList(_expensekey);

      // 2nd - convert the exisiting expenses to a list of expenses objects
      List<Expense> exisitingExpenseObject = [];
      if (exisitingExpenses != null) {
        exisitingExpenseObject = exisitingExpenses
            .map(
              (e) => Expense.fromJSON(json.decode(e)),
            )
            .toList();
      }
      // 3rd - remove the expense with the specified id from the list
      exisitingExpenseObject.removeWhere(
        (expense) => expense.id == id,
      );

      // 4th - convert the list of Expense objects back to a list of strings
      List<String> updatedExpenses =
          exisitingExpenseObject.map((e) => json.encode(e.toJASON())).toList();

      // 5th - save the updated list of expenses to shared preferences
      await pref.setStringList(_expensekey, updatedExpenses);

      // show message (snackbar)
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("වියදම් තොරතුර ඉවත් කරන ලදි!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      // show message (snackbar)
      if (context.mounted) {
        print(error.toString());
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("වියදම් තොරතුර ඉවත් කිරීම අසාර්තකයි!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }

  // delete all expenses from shared preferences
  Future<void> deleteAllExpenses(BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.remove(_expensekey);
      // show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("සියලු​ම වියදම් තොරතුර ඉවත් කරන ලදි"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (error) {
      print(error);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("සියලු​ම වියදම් තොරතු​රු ඉවත් කිරීම අසාර්තකයි!"),
            duration: Duration(seconds: 1),
          ),
        );
      }
    }
  }
}
