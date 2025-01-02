import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/category_card.dart';
import 'package:expenze/widget/pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class BudgetPage extends StatefulWidget {
  final Map<ExpenseCategory, double> expenseCategoryTotal;
  final Map<IncomeCategory, double> incomeCategoryTotal;
  const BudgetPage({
    super.key,
    required this.expenseCategoryTotal,
    required this.incomeCategoryTotal,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  // ස්ටේට් එක් ට්‍රැක් කරනවා ආදයම්ද වියදම්ද කියලා
  int _selectedMethod = 0;

  @override
  Widget build(BuildContext context) {
    // method to find the category color from the category
    Color getCategoryColor(dynamic category) {
      if (category is ExpenseCategory) {
        return expenseCategoryColor[category]!;
      } else {
        return incomeCategoryColor[category]!;
      }
    }

    final data = _selectedMethod == 0
        ? widget.expenseCategoryTotal
        : widget.incomeCategoryTotal;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: yellowColor,
        title: const Text(
          "uQ​,H jd¾;dj",
          style: TextStyle(
            fontFamily: "title",
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: AnimationLimiter(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 500),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // ------------- ටොගල් මෙනූ එක ---------------
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.06,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: lightGray,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMethod = 0;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeInOut,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: _selectedMethod == 1
                                              ? lightGray
                                              : blackColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 70,
                                          ),
                                          child: Text(
                                            "වියදම්",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _selectedMethod == 0
                                                  ? whiteColor
                                                  : blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _selectedMethod = 1;
                                        });
                                      },
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 100),
                                        curve: Curves.easeInOut,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: _selectedMethod == 0
                                              ? lightGray
                                              : blackColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 6,
                                            horizontal: 50,
                                          ),
                                          child: Text(
                                            "ආදායම්",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: _selectedMethod == 1
                                                  ? whiteColor
                                                  : blackColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          // ----------- Pie chart --------------//
                          Animate(
                            effects: [FadeEffect(), ScaleEffect()],
                            child: CustomPieChart(
                              expenseCategoryTotal: widget.expenseCategoryTotal,
                              incomeCategoryTotal: widget.incomeCategoryTotal,
                              isExpense: _selectedMethod == 0,
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          // --------- category list ----------//
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                final category = data.keys.toList()[index];
                                final total = data.values.toList()[index];
                                return CategoryCard(
                                  title: category.name,
                                  amount: total,
                                  total: data.values.reduce(
                                    (value, element) => value + element,
                                  ),
                                  progressColor: getCategoryColor(category),
                                  isExpense: _selectedMethod == 0,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
