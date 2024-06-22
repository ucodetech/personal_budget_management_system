import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:personal_budget_managemet/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Budget Tracker",
      theme: ThemeData(colorScheme: ColorScheme.light(surface: Colors.grey.shade100, onSurface: Colors.black, primary: Color.fromARGB(255, 0, 87, 114), secondary: Color.fromARGB(255, 177, 2, 98), tertiary: Color.fromARGB(255, 247, 165, 13), outline: Colors.grey)),
      home: BlocProvider(
        create: (context) => GetExpensesBloc(
          FireBaseExpenseRepo()
        )..add(GetExpenses()),
        child:  const HomeScreen(),
      ),

    );
  }
}