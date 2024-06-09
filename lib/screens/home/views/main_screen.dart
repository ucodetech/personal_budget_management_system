
import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_managemet/screens/home/views/all_expenses_dart.dart';

class MainScreen extends StatelessWidget {
  final List<Expense> expenses;
  const MainScreen(this.expenses, {super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10) ,
      child: Column(
        children: [
          Row(
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 70, 2, 109)
                      ),
                    ),
                    const Icon(
                      CupertinoIcons.person_alt_circle,
                      color: Colors.white30
                    )
                  ],
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.outline
                      ),
                    ),
                    Text(
                      "Graveth",
                        style: TextStyle(
                        fontSize:  18,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground
                      ),
                    )
                  ]
                )
              ],
              ),
              IconButton(
              onPressed: () {}, 
              icon: Icon(CupertinoIcons.settings))
            ],
          ),
          const SizedBox(height:20,),
          Container(
            width:MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width/2,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.secondary,
                  Theme.of(context).colorScheme.tertiary,
                ],
                transform: const GradientRotation(pi/2),
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [
                  BoxShadow(
                    blurRadius: 4,
                    color: Color.fromARGB(255, 82, 1, 71),
                    offset: Offset(5, 5)
                  )
                ]
            ),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Total Balance",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold 
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  "N 5000.00",
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w600 
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
                              shape: BoxShape.circle
                            ) ,
                            child: const Center(
                             child:Icon(
                              CupertinoIcons.arrow_down,
                              size: 12,
                              color: Colors.greenAccent
                              ),
                            )
                          ),
                          const SizedBox(width: 8,),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                  "Income",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400 
                                  ),
                                ),
                                Text(
                                  "N 2500.00",
                                   style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600 
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                       Row(
                        children: [
                          Container(
                            width: 25,
                            height: 25,
                            decoration: const BoxDecoration(
                              color: Colors.white30,
                              shape: BoxShape.circle
                            ) ,
                            child: const Center(
                             child:Icon(
                              CupertinoIcons.arrow_up,
                              size: 12,
                              color: Colors.red
                              ),
                            )
                          ),
                          const SizedBox(width: 8),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text(
                                  "Expenses",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400 
                                  ),
                                ),
                                Text(
                                  "N 18500.00",
                                   style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600 
                                  ),
                                ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            )
          ),
          const SizedBox(height: 40,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 16,
                  color : Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold
                ),
              ),
               GestureDetector(
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AllExpense()),
                );
               },
                 child: const Text(
                  "View All",
                  style: TextStyle(
                    fontSize: 14,
                    color : Color.fromARGB(255, 2, 118, 177),
                    fontWeight: FontWeight.w400
                  ),
                               ),
               )
          ],
          ),
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
      ),
     ),
    );
  }
}