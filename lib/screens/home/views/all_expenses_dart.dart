import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_budget_managemet/screens/add_expense/views/edit_expense_screen.dart';
import 'package:personal_budget_managemet/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllExpense extends StatefulWidget {
  final List<Expense> expenses;
  final User user;

  const AllExpense(this.expenses, this.user, {super.key});

  @override
  State<AllExpense> createState() => _AllExpenseState();
}

class _AllExpenseState extends State<AllExpense> {
  late List<Expense> expenses;

  @override
  void initState() {
    super.initState();
    expenses = widget.expenses;
  }
      final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Expenses'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 66, 0, 97), // Set your desired background color here
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: expenses.isNotEmpty
                    ? ListView.builder(
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            expenses[i].category.name,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            formatMoney(expenses[i].amount),
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Theme.of(context).colorScheme.onSurface,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
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
                                    ),
                                    Row(
                                      children: [
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: IconButton(
                                            icon: const Icon(Icons.edit, color: Colors.blue),
                                            onPressed: () async {
                                              // Handle edit button press
                                              final result = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => EditExpenseScreen(expenses[i]),
                                                ),
                                              );
                                              if (result == true) {
                                                setState(() {
                                                  // Refresh the expenses list or perform necessary updates
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        MouseRegion(
                                          cursor: SystemMouseCursors.click,
                                          child: IconButton(
                                            icon: const Icon(Icons.delete, color: Colors.red),
                                            onPressed: () {
                                              // Handle delete button press
                                              deleteExpense(context, expenses[i]);
                                            },
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
                      )
                    : const Text(
                        "You do not have any expenses yet!",
                        style: TextStyle(fontSize: 22, color: Colors.blue),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void deleteExpense(BuildContext context, Expense expense) {
    // Show a confirmation dialog before deleting
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Expense'),
          content: const Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () async {
                // Delete the expense from Firebase
              
                  final querySnapshot = await expenseCollection.where('expenseId', isEqualTo: expense.expenseId).get();
                  if (querySnapshot.docs.isNotEmpty) {
                    final docId = querySnapshot.docs.first.id;
                    final expenseRef = expenseCollection
                    .doc(docId);
                   await expenseRef.delete().then((_) {
                    setState(() {
                      expenses.remove(expense);
                    });
                    Navigator.of(context).pop();
                  }).catchError((error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete expense: $error')),
                    );
                  });
               }
              },
            ),
          ],
        );
      },
    );
  }
}
