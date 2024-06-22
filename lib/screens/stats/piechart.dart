import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:personal_budget_managemet/data/indicator.dart';
import 'package:personal_budget_managemet/data/app_resources.dart';

class MyPieChart extends StatefulWidget {
  final List<Expense> expenses;

  const MyPieChart(this.expenses, {super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<MyPieChart> {
  int touchedIndex = -1;
  final List<Color> availableColors = [
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.pink,
    Colors.brown,
    Colors.cyan,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Row(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: showingSections(),
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: indicators(),
          ),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    final Map<String, double> categorySums = {};

    // Calculate the sum of expenses for each category
    for (var expense in widget.expenses) {
      categorySums.update(
        expense.category.name,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    // Get the total sum of all expenses
    final double totalSum =
        categorySums.values.fold(0, (previous, amount) => previous + amount);

    final List<PieChartSectionData> sections = [];
    final List<Color> assignedColors = [];
    int colorIndex = 0;

    categorySums.forEach((category, amount) {
      final percentage = (amount / totalSum) * 100;
      final isTouched = sections.length == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      final color = availableColors[colorIndex % availableColors.length];
      assignedColors.add(color);

      sections.add(PieChartSectionData(
        color: color,
        value: percentage,
        title: '${percentage.toStringAsFixed(1)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          shadows: shadows,
        ),
      ));
      colorIndex++;
    });

    return sections;
  }

  List<Widget> indicators() {
    final Map<String, double> categorySums = {};

    // Calculate the sum of expenses for each category
    for (var expense in widget.expenses) {
      categorySums.update(
        expense.category.name,
        (value) => value + expense.amount,
        ifAbsent: () => expense.amount,
      );
    }

    final List<Widget> indicatorWidgets = [];
    int colorIndex = 0;

    categorySums.keys.forEach((category) {
      final color = availableColors[colorIndex % availableColors.length];
      indicatorWidgets.add(Indicator(
        color: color,
        text: category,
        isSquare: true,
      ));
      colorIndex++;
    });

    return indicatorWidgets;
  }
}
