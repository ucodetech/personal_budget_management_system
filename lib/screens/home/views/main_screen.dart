
import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:personal_budget_managemet/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_money_bloc/get_money_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/views/add_money.dart';
import 'package:personal_budget_managemet/screens/auth/upload_profile_photo.dart';
import 'package:personal_budget_managemet/screens/home/views/all_expenses_dart.dart';
import 'package:personal_budget_managemet/utils/utils.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  final User user;
  const MainScreen(this.expenses, this.user, { super.key});

  // Function to calculate total expenses
  double getTotalExpenses() {
    double total = 0;
    for (var expense in expenses) {
      // Ensure the expense amount is valid
      if (expense.amount != 0) {
        total += expense.amount;
      } else {
        return 0;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onDoubleTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ProfilePhotoUploadScreen()),
                        );
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 70, 2, 109),
                            ),
                          ),
                          Column(
                            children: [
                              user.photoURL != null
                                ? ClipOval(
                                    child: Image.network(
                                      user.photoURL!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.contain
                                      
                                    ),
                                  )
                                : const Icon(Icons.account_circle, size: 100),
                            ],
                          ),
                         
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          "${user.displayName}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const AddMoney()),
                        );
                      },
                      icon: const Icon(CupertinoIcons.settings, color: Color.fromARGB(255, 33, 0, 39),),
                    ),
                    IconButton(
                      onPressed: () {
                       context.read<SignInBloc>().add(const SignOutRequired());
                      },
                      icon: const Icon(Icons.logout, color: Colors.red,),
                    ),
                  ],
                ),
                
              ],
            ),
            const SizedBox(height: 20),
           BlocProvider(
              create: (context) => GetMoneyBloc(FireBaseExpenseRepo())..add(GetMoney(user.uid)),
              child: BlocBuilder<GetMoneyBloc, GetMoneyState>(
                builder: (context, state) {
                  double totalBalance = 0.0;
                  double income = 0.0;

                  if (state is GetMoneyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetMoneySuccess) {
                    totalBalance = state.amount;
                    income = state.income;
                  } else if (state is GetMoneyFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  }

                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                          Theme.of(context).colorScheme.tertiary,
                        ],
                        transform: const GradientRotation(pi / 2),
                      ),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color.fromARGB(255, 82, 1, 71),
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Total Balance",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          formatMoney(totalBalance),
                       
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.arrow_down,
                                        size: 12,
                                        color: Colors.greenAccent,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                   Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Income",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                         formatMoney(income),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        CupertinoIcons.arrow_up,
                                        size: 12,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Expenses",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                         formatMoney(getTotalExpenses()),
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Transactions",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AllExpense(expenses, user)),
                    );
                  },
                  child: const Text(
                    "View All",
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 2, 118, 177),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              
              child:  expenses.isNotEmpty ? ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, int i) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: Color(expenses[i].category.color),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Image.asset(
                                      'assets/${expenses[i].category.icon}.png',
                                      scale: 2,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 12),
                                Text(
                                  expenses[i].category.name,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                   formatMoney(expenses[i].amount),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onSurface,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                   formatDate(expenses[i].date),
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ) : Container(
                child: const Text(
                  "You do not have any expenses yet!",
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue
                ),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }
}