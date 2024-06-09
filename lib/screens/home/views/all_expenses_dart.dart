import 'package:flutter/material.dart';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../blocs/get_expenses_bloc/get_expenses_bloc.dart';

class AllExpense extends StatelessWidget {
  const AllExpense({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),
        backgroundColor: const Color.fromARGB(255, 2, 118, 177), // Custom AppBar color
      ),
      body: BlocBuilder<GetExpensesBloc, GetExpensesState>(
        builder: (context, state) {
          if (state is GetExpensesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetExpensesSuccess) {
           var expense = state.expenses;
            if (expense.isEmpty) {
              return const Center(child: Text('No expense found.'));
            }
            return ListView.builder(
              itemCount: expense.length,
              itemBuilder: (context, i) {
                return  ListView.builder(
                  // itemCount: expense.length,
                  itemCount: expense.length,
                  itemBuilder: (context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)
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
                                        decoration:  BoxDecoration(
                                          color: Color(expense[i].category.color),
                                          shape: BoxShape.circle
                                        ),
                                      ),
                                      
                                      Image.asset(
                                        'assets/${expense[i].category.icon}.png',
                                        scale: 2,
                                        color: Colors.white,
                                      )
                                    ],
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    // expense[i].category.name,
                                    expense[i].category.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "N${expense[i].amount}0",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.onSurface,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd/MM/yyyy').format(expense[i].date),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).colorScheme.outline,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                );
               }
              );
            
          } else if (state is GetExpensesFailure) {
            return const Center(child: Text('Failed to load expenses.'));
          }
          return const Center(child: Text('Unexpected state.'));
        },
      ),
    );
  }
}
