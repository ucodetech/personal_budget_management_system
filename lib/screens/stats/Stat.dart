// import 'package:fl_chart/fl_chart.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';

import 'chart.dart';
import 'piechart.dart';

class StatScreen extends StatefulWidget {

  final List<Expense> expenses;

  const StatScreen(this.expenses, {super.key});

  @override
  State<StatScreen> createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {

   late List<Expense> expenses;

  @override
  void initState() {
    super.initState();
    expenses = widget.expenses;
  }
  
  @override
  Widget build(BuildContext context) {
     return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Transactions ',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                          child: MyChart(expenses),
                        ),
                      ),
                      const SizedBox(height: 20), // Space between the two charts
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child:  Padding(
                          padding: EdgeInsets.fromLTRB(12, 20, 12, 12),
                          child: MyPieChart(expenses), // Pie chart widget
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );

    }
}