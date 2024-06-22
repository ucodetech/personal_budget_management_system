import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:personal_budget_managemet/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_money_bloc/get_money_bloc.dart';
import 'package:personal_budget_managemet/screens/home/blocs/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:personal_budget_managemet/screens/home/views/home_screen.dart';
import 'package:personal_budget_managemet/screens/home/welcome_screen.dart';

class MyAppView extends StatelessWidget {

   const MyAppView({super.key});


  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Budget Tracker",
      theme: ThemeData(
          colorScheme: ColorScheme.light(
              surface: Colors.grey.shade100,
              onSurface: Colors.black,
              primary: const Color.fromARGB(255, 0, 87, 114),
              secondary: const Color.fromARGB(255, 177, 2, 98),
              tertiary: const Color.fromARGB(255, 247, 165, 13),
              outline: Colors.grey)),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state){
          if(state.status == AuthenticationStatus.authenticated){
            final user = FirebaseAuth.instance.currentUser!;
            
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => SignInBloc(
                      userRepository: context.read<AuthenticationBloc>().userRepository
                    ),
                ),
                BlocProvider(
                  create: (context) =>
                      GetExpensesBloc(FireBaseExpenseRepo())..add(GetExpenses(user.uid)),
                ),
                BlocProvider(
                  create: (context) => GetMoneyBloc(FireBaseExpenseRepo())..add(GetMoney(user.uid)),
                ),
              ],
              child: const HomeScreen(),
            );
          }else{
              return const WelcomeScreen();
          }
        } 
      )
    );
  }
}
