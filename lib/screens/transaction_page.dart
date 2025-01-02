import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/expense_card.dart';
import 'package:expenze/widget/income_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TransactionPage extends StatefulWidget {
  final List<Expense> expensesList;
  final void Function(Expense) onDismissedExpense;
  final List<Income> incomeList;
  final void Function(Income) onDismissedIncome;

  const TransactionPage({
    super.key,
    required this.expensesList,
    required this.onDismissedExpense,
    required this.incomeList,
    required this.onDismissedIncome,
  });

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        //toolbarHeight: 40,
        backgroundColor: yellowColor,
        title: const Center(
          child: Text(
            ".kqfo​kq",
            style: TextStyle(
              fontFamily: "title",
              fontSize: 27,
              color: blackColor,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // ----------- Expenses Section -------------- //
                const Text(
                  "වියදම්:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.31,
                  child: AnimationLimiter(
                    child: Column(
                      children: [
                        widget.expensesList.isEmpty
                            ? Placeholder(
                                fallbackHeight:
                                    MediaQuery.of(context).size.height * 0.31,
                                color: whiteColor,
                                child: const Center(
                                  child: Text(
                                    "ඔබ විසින් තවමත් වියදම් තොරතුරු ඇතුලත් කර නැත. කරුණාකර තොරතුරු ඇතුලත් කරන්න.",
                                    style: TextStyle(
                                      color: darkGray,
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.31,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.expensesList.length,
                                  itemBuilder: (context, index) {
                                    final expense = widget.expensesList[index];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: Dismissible(
                                            key: ValueKey(expense),
                                            direction:
                                                DismissDirection.startToEnd,
                                            onDismissed: (direction) {
                                              setState(() {
                                                widget.onDismissedExpense(
                                                    expense);
                                              });
                                            },
                                            background: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: ExpenseCard(
                                              title: expense.title,
                                              date: expense.date,
                                              time: expense.time,
                                              amount: expense.amount,
                                              description: expense.description,
                                              category: expense.category,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 23),
                // ----------- Income Section -------------- //
                const Text(
                  "ආදායම්:",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.31,
                  child: AnimationLimiter(
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty
                            ? Placeholder(
                                fallbackHeight:
                                    MediaQuery.of(context).size.height * 0.31,
                                color: whiteColor,
                                child: const Center(
                                  child: Text(
                                    "ඔබ විසින් තවමත් ආදායම් තොරතුරු ඇතුලත් කර නැත. කරුණාකර තොරතුරු ඇතුලත් කරන්න.",
                                    style: TextStyle(
                                      color: darkGray,
                                      fontSize: 15,
                                      //fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.31,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: widget.incomeList.length,
                                  itemBuilder: (context, index) {
                                    final income = widget.incomeList[index];
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 50.0,
                                        child: FadeInAnimation(
                                          child: Dismissible(
                                            key: ValueKey(income),
                                            direction:
                                                DismissDirection.startToEnd,
                                            onDismissed: (direction) {
                                              setState(() {
                                                widget
                                                    .onDismissedIncome(income);
                                              });
                                            },
                                            background: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              alignment: Alignment.centerLeft,
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: const Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            child: IncomeCard(
                                              title: income.title,
                                              date: income.date,
                                              time: income.time,
                                              amount: income.amount,
                                              description: income.description,
                                              category: income.category,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
