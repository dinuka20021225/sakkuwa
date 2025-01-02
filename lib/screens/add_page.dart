import 'package:expenze/models/expens_model.dart';
import 'package:expenze/models/income_model.dart';
import 'package:expenze/services/expense_service.dart';
import 'package:expenze/services/income_service.dart';
import 'package:expenze/utilities/colors.dart';
import 'package:expenze/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  final Function(Expense) addExpense;
  final Function(Income) addIncome;
  const AddPage({
    super.key,
    required this.addExpense,
    required this.addIncome,
  });

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  // ස්ටේට් එක් ට්‍රැක් කරනවා ආදයම්ද වියදම්ද කියලා
  int _selectedMethod = 0;

  ExpenseCategory _expenseCategory = ExpenseCategory.Shopping;
  IncomeCategory _incomeCategory = IncomeCategory.Salary;

  // text editing controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // දිනය සහ වේලාව සේව් කර ගැනීම
  DateTime _selecetedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: _selectedMethod == 0 ? darkBlue : lightBlue,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 300),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  Stack(
                    children: [
                      // ------------- ටොගල් මෙනූ එක ---------------
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: whiteColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedMethod = 0;
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: _selectedMethod == 1
                                        ? whiteColor
                                        : darkBlue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 70,
                                    ),
                                    child: Text(
                                      "වියදම්",
                                      style: TextStyle(
                                        fontSize: 18,
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
                                  duration: const Duration(milliseconds: 100),
                                  curve: Curves.easeInOut,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: _selectedMethod == 0
                                        ? whiteColor
                                        : lightBlue,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 45,
                                    ),
                                    child: Text(
                                      "ආදායම්",
                                      style: TextStyle(
                                        fontSize: 18,
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
                      //-------------- Amount feild එක -----------------//
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.1,
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "කොපමණක්ද?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                              ),
                              TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold,
                                  color: whiteColor,
                                ),
                                decoration: InputDecoration(
                                  hintText: "0",
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // ------------- User data form -----------------
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.24,
                        ),
                        decoration: const BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                // ----- drop down menu එක -----
                                DropdownButtonFormField(
                                  borderRadius: BorderRadius.circular(15),
                                  dropdownColor: yellowColor,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    contentPadding: const EdgeInsets.all(15),
                                  ),
                                  items: _selectedMethod == 0
                                      ? ExpenseCategory.values.map((category) {
                                          return DropdownMenuItem(
                                            value: category,
                                            child: Text(category.name),
                                          );
                                        }).toList()
                                      : IncomeCategory.values.map((category) {
                                          return DropdownMenuItem(
                                              value: category,
                                              child: Text(category.name));
                                        }).toList(),
                                  value: _selectedMethod == 0
                                      ? _expenseCategory
                                      : _incomeCategory,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMethod == 0
                                          ? _expenseCategory =
                                              value as ExpenseCategory
                                          : _incomeCategory =
                                              value as IncomeCategory;
                                    });
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "කරුණාකර මාතෘකාව ඇතුලත් කරන්න";
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  controller: _titleController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "මාතෘකාව...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "කරුණාකර විස්තර​ය ඇතුලත් කරන්න";
                                    }
                                    return null;
                                  },
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    hintText: "විස්තරය...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "කරුණාකර මුදල ඇතුලත් කරන්න.";
                                    }
                                    double? amount = double.tryParse(value);
                                    if (amount == null || amount <= 0) {
                                      return "කරුණාකර නිවැරදි අගයක් ඇතුලත් කරන්න";
                                    }
                                    return null;
                                  },
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  controller: _amountController,
                                  decoration: InputDecoration(
                                    counterText: "",
                                    hintText: "මුදල...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                // ------ date picker ------
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(2020),
                                          lastDate: DateTime(2026),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: Colors
                                                    .orange, // Header background color
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary:
                                                      blackColor, // Selected date color
                                                  onPrimary: Colors
                                                      .white, // Text color on selected date
                                                  surface:
                                                      yellowColor, // Calendar background color
                                                ),
                                                buttonTheme:
                                                    const ButtonThemeData(
                                                  textTheme: ButtonTextTheme
                                                      .primary, // Button text color
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ).then((value) {
                                          if (value != null) {
                                            setState(() {
                                              _selecetedDate = value;
                                            });
                                          }
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: yellowColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_month,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "දවස තෝරන්න",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat.yMMMd().format(_selecetedDate),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                // ------ Time picker ------
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (BuildContext context,
                                              Widget? child) {
                                            return Theme(
                                              data: ThemeData.light().copyWith(
                                                primaryColor: Colors
                                                    .orange, // Header background color
                                                colorScheme:
                                                    const ColorScheme.light(
                                                  primary:
                                                      blackColor, // Selected time color
                                                  onPrimary: Colors
                                                      .white, // Text color on selected time
                                                  surface:
                                                      yellowColor, // Background color for the dialog
                                                ),
                                                buttonTheme:
                                                    const ButtonThemeData(
                                                  textTheme: ButtonTextTheme
                                                      .primary, // Button text color
                                                ),
                                                // ignore: prefer_const_constructors
                                                timePickerTheme:
                                                    const TimePickerThemeData(
                                                  dayPeriodColor: Colors
                                                      .black, // Background color of AM/PM selector
                                                  dayPeriodTextColor:
                                                      whiteColor, // Text color of AM/PM selector
                                                  dayPeriodShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8.0),
                                                    ), // Optional: Rounded shape
                                                  ),
                                                ),
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ).then((value) {
                                          setState(() {
                                            if (value != null) {
                                              _selectedTime = DateTime(
                                                _selecetedDate.year,
                                                _selecetedDate.month,
                                                _selecetedDate.day,
                                                value.hour,
                                                value.minute,
                                              );
                                            }
                                          });
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          color: yellowColor,
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 20,
                                            vertical: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.watch_later_outlined,
                                                size: 30,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "වෙලා​ව තෝරන්න",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      DateFormat.jm().format(_selectedTime),
                                      style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 30,
                                ),

                                // ---------- Submit Button -----------//
                                GestureDetector(
                                  onTap: () async {
                                    if (_formkey.currentState!.validate()) {
                                      // save the epense or the income data into share pref
                                      if (_selectedMethod == 0) {
                                        // --------- adding expenses --------- //

                                        List<Expense> loadedExpenses =
                                            await ExpenseService()
                                                .loadExpenses();

                                        // create expense to store
                                        Expense expense = Expense(
                                          id: loadedExpenses.length + 1,
                                          title: _titleController.text,
                                          amount: _amountController.text.isEmpty
                                              ? 0
                                              : double.parse(
                                                  _amountController.text),
                                          category: _expenseCategory,
                                          date: _selecetedDate,
                                          time: _selectedTime,
                                          description:
                                              _descriptionController.text,
                                        );

                                        // add expense
                                        widget.addExpense(expense);

                                        // clear the field
                                        _titleController.clear();
                                        _amountController.clear();
                                        _descriptionController.clear();
                                      } else {
                                        // load incomes
                                        List<Income> loadedIncomes =
                                            await IncomeService().loadIncomes();
                                        // create the new income
                                        Income income = Income(
                                          id: loadedIncomes.length + 1,
                                          title: _titleController.text,
                                          amount: _amountController.text.isEmpty
                                              ? 0
                                              : double.parse(
                                                  _amountController.text),
                                          category: _incomeCategory,
                                          date: _selecetedDate,
                                          time: _selectedTime,
                                          description:
                                              _descriptionController.text,
                                        );

                                        // add income
                                        widget.addIncome(income);

                                        // clear the field
                                        _titleController.clear();
                                        _amountController.clear();
                                        _descriptionController.clear();
                                      }
                                    }
                                  },
                                  child: CustomButton(
                                    title: "we;=,;a lrka​k",
                                    buttonColor: _selectedMethod == 0
                                        ? darkBlue
                                        : lightBlue,
                                    titleColor: whiteColor,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
