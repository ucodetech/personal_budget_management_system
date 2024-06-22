import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_money_bloc/get_money_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/views/add_expense.dart';
import 'package:personal_budget_managemet/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:personal_budget_managemet/screens/home/views/main_screen.dart';
import 'package:personal_budget_managemet/screens/stats/Stat.dart';

class HomeScreen extends StatefulWidget {
  
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Color selectedItem = Color.fromARGB(255, 71, 0, 73);
  Color unselectedItem = Colors.grey;

    final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if(state is GetExpensesSuccess){
          return Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              child: BottomNavigationBar(
                  onTap: (value) {
                    setState(() {
                      index = value;
                      
                    });
                  },
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  elevation: 3,
                  items: [
                    BottomNavigationBarItem(
                      
                        icon: Icon(CupertinoIcons.home,
                            color: index == 0 ? selectedItem : unselectedItem),
                        label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(CupertinoIcons.graph_square_fill,
                            color: index == 1 ? selectedItem : unselectedItem),
                        label: 'Stats')
                  ]),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                Expense? newExpense = await  Navigator.push(
                    context,
                    MaterialPageRoute<Expense>(
                      builder: (context) => MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) =>
                                CreateCategoryBloc(FireBaseExpenseRepo()),
                          ),
                          BlocProvider(
                            create: (context) =>
                                GetCategoriesBloc(FireBaseExpenseRepo())
                                  ..add(GetCategories(user.uid)),
                          ),
                          BlocProvider(
                            create: (context) =>
                                CreateExpenseBloc(FireBaseExpenseRepo()),
                          ),
                         BlocProvider(
                            create: (context) =>
                                GetMoneyBloc(FireBaseExpenseRepo())
                                  ..add(GetMoney(user.uid)),
                          ),
                                          
                    ],
                    child: const AddExpense(),
                  )));
                  if(newExpense != null){
                      setState(() {
                        state.expenses.insert(0, newExpense);
                        
                      });
                  }
              },
              shape: const CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.secondary,
                        Theme.of(context).colorScheme.tertiary,
                      ],
                      transform: const GradientRotation(pi / 10),
                    ),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 4,
                          color: Color.fromARGB(255, 82, 1, 71),
                          offset: Offset(3, 5))
                    ]),
                child: const Icon(CupertinoIcons.add),
              ),
            ),
            body: index == 0 ?  MainScreen(state.expenses, user) :  StatScreen(state.expenses),
          );
        }else{
          return const Scaffold(
              body: Center(
                child:  CircularProgressIndicator(),
              ),
          );
        }
      }
     );
    }
   
  }

