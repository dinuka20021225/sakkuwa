import 'package:expenze/utilities/colors.dart';
import 'package:flutter/material.dart';

enum IncomeCategory {
  Salary,
  Freelance,
  Passive,
  Sales,
}

// income category images
final Map<IncomeCategory, String> incomeCategoryImages = {
  IncomeCategory.Salary: "assets/images/salary.png",
  IncomeCategory.Freelance: "assets/images/freelance.png",
  IncomeCategory.Passive: "assets/images/passive.png",
  IncomeCategory.Sales: "assets/images/sales.png",
};

// income category colors
final Map<IncomeCategory, Color> incomeCategoryColor = {
  IncomeCategory.Salary: const Color(0xff118ab2),
  IncomeCategory.Freelance: lightBlue2,
  IncomeCategory.Passive: const Color(0xff06d6a0),
  IncomeCategory.Sales: const Color(0xffffd166),
};

class Income {
  final int id;
  final String title;
  final double amount;
  final IncomeCategory category;
  final DateTime date;
  final DateTime time;
  final String description;

  Income({
    required this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    required this.time,
    required this.description,
  });

  // converting income object to the json
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

  // create an income object from a jason object (Deserialization)
  factory Income.fromJASON(Map<String, dynamic> jason) {
    return Income(
      id: jason["id"],
      title: jason["title"],
      amount: jason["amount"],
      category: IncomeCategory.values[jason["category"]],
      date: DateTime.parse(jason["date"]),
      time: DateTime.parse(jason["time"]),
      description: jason["description"],
    );
  }
}
