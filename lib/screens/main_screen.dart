import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/screens/add_page.dart';
import 'package:expenze/screens/budget_page.dart';
import 'package:expenze/screens/home_page.dart';
import 'package:expenze/screens/profile_page.dart';
import 'package:expenze/screens/transaction_page.dart';
import 'package:expenze/services/expense_service.dart';
import 'package:expenze/services/income_service.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // current page index
  int _curentPageIndex = 0;

  List<Expense> expenseList = [];
  List<Income> incomeList = [];

  // function to fetch expenses
  void fetchAllExpenses() async {
    List<Expense> loadedExpenses = await ExpenseService().loadExpenses();
    setState(() {
      expenseList = loadedExpenses;
    });
  }

  // function to fetch icomes
  void fetchAllIncomes() async {
    List<Income> loadedIncomes = await IncomeService().loadIncomes();
    setState(() {
      incomeList = loadedIncomes;
    });
  }

  // function to add a new expense
  void addNewExpense(Expense newExpense) {
    ExpenseService().saveExpenses(newExpense, context);

    // update the list of expense
    setState(() {
      expenseList.add(newExpense);
    });
  }

  // function to add a new income
  void addNewIncome(Income newIncome) {
    IncomeService().saveIncome(newIncome, context);

    // update the list of income
    setState(() {
      incomeList.add(newIncome);
      print(incomeList.length);
    });
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
  }

  // function to remove a expense
  void removeExpense(Expense expense) {
    ExpenseService().deleteExpense(expense.id, context);
    setState(() {
      expenseList.remove(expense);
    });
  }

  // function to remove a income
  void removeIncome(Income income) {
    IncomeService().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  // category total expense
  Map<ExpenseCategory, double> calculateExpenseCategories() {
    Map<ExpenseCategory, double> categoryTotals = {
      ExpenseCategory.Food: 0,
      ExpenseCategory.Health: 0,
      ExpenseCategory.Shopping: 0,
      ExpenseCategory.Subscriptions: 0,
      ExpenseCategory.Transport: 0,
    };
    for (Expense expense in expenseList) {
      categoryTotals[expense.category] =
          categoryTotals[expense.category]! + expense.amount;
    }
    return categoryTotals;
  }

  // category total income
  Map<IncomeCategory, double> calculateIncomeCategories() {
    Map<IncomeCategory, double> categoryTotals = {
      IncomeCategory.Freelance: 0,
      IncomeCategory.Passive: 0,
      IncomeCategory.Salary: 0,
      IncomeCategory.Sales: 0,
    };
    for (Income income in incomeList) {
      categoryTotals[income.category] =
          categoryTotals[income.category]! + income.amount;
    }
    return categoryTotals;
  }

  @override
  Widget build(BuildContext context) {
    // පේජ් ලිස්ට් එක
    final List<Widget> pages = [
      HomePage(
        expensesList: expenseList,
        incomesList: incomeList,
      ),
      TransactionPage(
        expensesList: expenseList,
        onDismissedExpense: removeExpense,
        incomeList: incomeList,
        onDismissedIncome: removeIncome,
      ),
      AddPage(
        addExpense: addNewExpense,
        addIncome: addNewIncome,
      ),
      BudgetPage(
        expenseCategoryTotal: calculateExpenseCategories(),
        incomeCategoryTotal: calculateIncomeCategories(),
      ),
      ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: yellowColor,
        unselectedItemColor: blackColor,
        selectedLabelStyle: const TextStyle(
          fontFamily: "title",
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: "title",
        ),
        currentIndex: _curentPageIndex,
        onTap: (index) {
          setState(() {
            _curentPageIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: "uq,a msgqj",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.moneyBillTransfer,
            ),
            label: ".kqfokq",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: yellowColor,
              ),
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: blackColor,
                ),
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.chartPie,
            ),
            label: "jd¾;d",
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.solidUser,
            ),
            label: "f;dr;=re",
          )
        ],
      ),
      body: pages[_curentPageIndex],
    );
  }
}
