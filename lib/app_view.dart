import 'package:flutter/material.dart';
import 'package:personal_budget_managemet/screens/home/views/home_screen.dart';

class MyAppView extends StatelessWidget {
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Personal Budget Tracker",
      theme: ThemeData(colorScheme: ColorScheme.light(background: Colors.grey.shade100, onBackground: Colors.black, primary: Color.fromARGB(255, 0, 87, 114), secondary: Color.fromARGB(255, 177, 2, 98), tertiary: Color.fromARGB(255, 247, 165, 13), outline: Colors.grey)),
      home: HomeScreen(
        
      ),

    );
  }
}