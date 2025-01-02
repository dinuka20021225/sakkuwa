import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/screens/transaction_page.dart';
import 'package:expenze/services/user_service.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/expense_card.dart';
import 'package:expenze/widget/income_expence_card.dart';
import 'package:expenze/widget/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  final List<Expense> expensesList;
  final List<Income> incomesList;

  const HomePage({
    super.key,
    required this.expensesList,
    required this.incomesList,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //යූසර් නේම් එක සේව් කර ගැනීම
  String username = "";
  String email = "";
  double incomeTotal = 0;
  double expenseTotal = 0;

  @override
  void initState() {
    UserService.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });

    setState(() {
      // total ammount of expenses
      for (var i = 0; i < widget.expensesList.length; i++) {
        expenseTotal += widget.expensesList[i].amount;
      }
      for (var k = 0; k < widget.incomesList.length; k++) {
        incomeTotal += widget.incomesList[k].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: yellowColor,
        toolbarHeight: 0,
      ),
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 500),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.23,
                            decoration: const BoxDecoration(
                              color: yellowColor,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 0,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: whiteColor,
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                            color: blackColor,
                                            width: 3,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.asset(
                                              "assets/images/dinuka.jpg",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "Welcome",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Inter",
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            username,
                                            style: const TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      const Spacer(),
                                      IconButton(
                                          onPressed: () {},
                                          icon: const FaIcon(
                                            FontAwesomeIcons.solidBell,
                                            color: blackColor,
                                          ))
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IncomeExpenceCard(
                                        title: "ආදාය​ම",
                                        amount: incomeTotal,
                                        imageUrl: "assets/images/income.png",
                                        bgColor: blackColor,
                                        imageColor: greenColor,
                                      ),
                                      IncomeExpenceCard(
                                        title: "වියදම",
                                        amount: expenseTotal,
                                        imageUrl: "assets/images/expense.png",
                                        bgColor: blackColor,
                                        imageColor: redColor,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ---------- Line chart section -------------//
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "වියදම් සංක්‍යාතය",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                // Line chart
                                const LineChartSample(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "මෑතකදී සිදු කල ගනුදෙනු",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TransactionPage(
                                                  expensesList: const [],
                                                  onDismissedExpense:
                                                      (Expense) {},
                                                  incomeList: const [],
                                                  onDismissedIncome:
                                                      (Income) {},
                                                ),
                                              ),
                                            );
                                          },
                                          icon: const FaIcon(
                                            FontAwesomeIcons.solidEye,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      children: [
                                        widget.expensesList.isEmpty
                                            ? const Placeholder(
                                                fallbackHeight: 195,
                                                color: whiteColor,
                                                child: Center(
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
                                                height: 199,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount: widget
                                                      .expensesList.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final expense = widget
                                                        .expensesList[index];
                                                    return AnimationConfiguration
                                                        .staggeredList(
                                                      position: index,
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      child: SlideAnimation(
                                                        verticalOffset: 50.0,
                                                        child: FadeInAnimation(
                                                          child: ExpenseCard(
                                                            title:
                                                                expense.title,
                                                            date: expense.date,
                                                            time: expense.time,
                                                            amount:
                                                                expense.amount,
                                                            description: expense
                                                                .description,
                                                            category: expense
                                                                .category,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
