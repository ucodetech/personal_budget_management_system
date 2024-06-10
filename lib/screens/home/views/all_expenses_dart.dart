
import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AllExpense extends StatelessWidget {
  final List<Expense> expenses;
  const AllExpense(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),
      ),
      body: Container(
         decoration: const BoxDecoration(
          color: Color.fromARGB(255, 66, 0, 97), // Set your desired background color here
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10) ,
          child: Column(
            children: [
                  const SizedBox(height: 20),
                  Expanded(
                  child: ListView.builder(
                        // itemCount: expenses.length,
                        itemCount: expenses.length,
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
                                                color: Color(expenses[i].category.color),
                                                shape: BoxShape.circle
                                              ),
                                            ),
                                            
                                            Image.asset(
                                              'assets/${expenses[i].category.icon}.png',
                                              scale: 2,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                        const SizedBox(width: 12),
                                        Text(
                                          // expenses[i].category.name,
                                          expenses[i].category.name,
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
                                          "N${expenses[i].amount}0",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Theme.of(context).colorScheme.onSurface,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        Text(
                                          DateFormat('dd/MM/yyyy').format(expenses[i].date),
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
                      ),
                  ),
                    
              ],
          )
        ),
      ),
    );
  }
}