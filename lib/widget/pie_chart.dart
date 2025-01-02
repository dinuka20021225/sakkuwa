import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CustomPieChart extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  final bool isExpense;
  const CustomPieChart({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  });

  @override
  State<CustomPieChart> createState() => _CustomPieChartState();
}

class _CustomPieChartState extends State<CustomPieChart> {
  // section datas
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.Food],
          value: widget.expenseCategoryTotal[ExpenseCategory.Food] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.Health],
          value: widget.expenseCategoryTotal[ExpenseCategory.Health] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.Shopping],
          value: widget.expenseCategoryTotal[ExpenseCategory.Shopping] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.Subscriptions],
          value:
              widget.expenseCategoryTotal[ExpenseCategory.Subscriptions] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[ExpenseCategory.Transport],
          value: widget.expenseCategoryTotal[ExpenseCategory.Transport] ?? 0,
          showTitle: false,
          radius: 100,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Freelance],
          value: widget.incomeCategoryTotal[IncomeCategory.Freelance] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Passive],
          value: widget.incomeCategoryTotal[IncomeCategory.Passive] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Salary],
          value: widget.incomeCategoryTotal[IncomeCategory.Salary] ?? 0,
          showTitle: false,
          radius: 100,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[IncomeCategory.Sales],
          value: widget.incomeCategoryTotal[IncomeCategory.Sales] ?? 0,
          showTitle: false,
          radius: 100,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 2,
      centerSpaceRadius: 0,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: whiteColor,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(pieChartData),
        ],
      ),
    );
  }
}
