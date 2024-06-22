import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/views/Includes/create_category_module.dart';
import 'package:personal_budget_managemet/widgets/button.dart';
import 'package:personal_budget_managemet/widgets/timer_w.dart';
import 'package:uuid/uuid.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectDate = DateTime.now();
  String message = '';
  bool Color_Status = true;
  late Expense expense;
  bool isLoading = false;

  @override
  void initState() {
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    expense = Expense.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if(state is CreateExpenseSuccess){
           setState(() {
             expense.category = Category.empty;
             expense = Expense.empty;
             message = "Expense Created!";
           });
          Navigator.pop(context, expense);
        }else if(state is CreateExpenseLoading){
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar:
              AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
            if (state is GetCategoriesSuccess) {
              var cat = state.categories;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Add Expenses',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: expenseController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Amount',
                          prefixIcon: const Icon(FontAwesomeIcons.nairaSign,
                              size: 16, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 65, 19, 73),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                  255, 148, 2, 2), // Border color when focused
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Border color when there is an error
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: categoryController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () {},
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: expense.category == Category.empty
                            ? Colors.white
                            : Color(expense.category.color),
                        hintText: 'Category',
                        prefixIcon: expense.category == Category.empty
                            ? const Icon(FontAwesomeIcons.list,
                                size: 16, color: Colors.grey)
                            : Image.asset('assets/${expense.category.icon}.png',
                                scale: 2),
                        suffixIcon: IconButton(
                            onPressed: () async {
                              // create category module
                              var newCategory =
                                  await getCreateCategoryModule(context);
                              if (newCategory != null) {
                                setState(() {
                                  cat.insert(0, newCategory);
                                });
                              }
                            },
                            icon: const Icon(FontAwesomeIcons.circlePlus,
                                size: 16, color: Colors.grey)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 65, 19, 73),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(
                                255, 148, 2, 2), // Border color when focused
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors
                                .red, // Border color when there is an error
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width,

                      // color: Colors.red,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: cat.length,
                            itemBuilder: (context, int i) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category = cat[i];
                                      categoryController.text =
                                          expense.category.name;
                                    });
                                  },
                                  leading: Image.asset(
                                      'assets/${cat[i].icon}.png',
                                      scale: 2),
                                  title: Text(
                                    cat[i].name,
                                  ),
                                  tileColor: Color(cat[i].color),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textColor: Colors.white,
                                ),
                              );
                            }),
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller: dateController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () async {
                        DateTime? newDate = await showDatePicker(
                            context: context,
                            initialDate: expense.date,
                            firstDate: DateTime.now(),
                            lastDate:
                                DateTime.now().add(const Duration(days: 365)));

                        if (newDate != null) {
                          setState(() {
                            dateController.text =
                                DateFormat('dd/MM/yyyy').format(newDate);
                            selectDate = newDate;
                            expense.date = newDate;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Date',
                        prefixIcon: const Icon(FontAwesomeIcons.clock,
                            size: 16, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(
                            color: Color.fromARGB(255, 65, 19, 73),
                            width: 2.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color.fromARGB(
                                255, 148, 2, 2), // Border color when focused
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors
                                .red, // Border color when there is an error
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    //  
                     SizedBox(
                      child: isLoading == true
                          ? const Center(child: CircularProgressIndicator(),)
                          :  Button(
                              text: 'Save Expenses',
                              icon: Icons.save,
                              onPressed: () {
                                // Your save action here
                                setState(() {
                                  expense.expenseId = const Uuid().v1();
                                  expense.amount = double.parse(expenseController.text);
                                  expense.userId = const Uuid().v4();
                                });
                              context.read<CreateExpenseBloc>().add(CreateExpense(expense));
                            }
                          // Navigator.pop(context);
                          ),
                      ),
                      
                    const SizedBox(height: 16),
                    SizedBox(
                      child: TimerWidget(
                        initialMessage: message,
                        duration: const Duration(seconds: 5),
                        color_status: Color_Status,
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
