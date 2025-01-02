import 'dart:math';
import 'dart:ui';

import 'package:expenze/utilities/colors.dart';

enum ExpenseCategory {
  Shopping,
  Subscriptions,
  Food,
  Health,
  Transport,
}

// expens category images
final Map<ExpenseCategory, String> expenseCategoryimages = {
  ExpenseCategory.Shopping: "assets/images/shopping.png",
  ExpenseCategory.Subscriptions: "assets/images/subscription.png",
  ExpenseCategory.Food: "assets/images/food.png",
  ExpenseCategory.Health: "assets/images/health.png",
  ExpenseCategory.Transport: "assets/images/transport.png",
};

// income category colors
final Map<ExpenseCategory, Color> expenseCategoryColor = {
  ExpenseCategory.Shopping: sunYellow,
  ExpenseCategory.Subscriptions: const Color.fromARGB(255, 57, 149, 211),
  ExpenseCategory.Food: softred,
  ExpenseCategory.Health: pink,
  ExpenseCategory.Transport: teel,
};

class Expense {
  final int id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  //expense objects ටික jason වලට convert කර ගන්න​වා.
  Map<String, dynamic> toJASON() {
    return {
      "id": id,
      "title": title,
      "amount": amount,
      "category": category.index,
      "date": date.toIso8601String(),
      "time": time.toIso8601String(),
      "description": description,
    };
  }

  // create an expense object from a JSON object.
  factory Expense.fromJSON(Map<String, dynamic> json) {
    return Expense(
      id: json["id"],
      title: json["title"],
      amount: json["amount"],
      category: ExpenseCategory.values[json["category"]],
      date: DateTime.parse(json["date"]),
      time: DateTime.parse(json["time"]),
      description: json["description"],
    );
  }
}
