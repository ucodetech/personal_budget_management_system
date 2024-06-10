import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/get_categories_bloc/get_categories_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/views/Includes/create_category_module.dart';
import 'package:personal_budget_managemet/widgets/button.dart';
import 'package:personal_budget_managemet/widgets/timer_w.dart';
import 'package:uuid/uuid.dart';

class AddMoney extends StatefulWidget {
  const AddMoney({super.key});

  @override
  State<AddMoney> createState() => _AddMoneyState();
}

class _AddMoneyState extends State<AddMoney> {
  
  TextEditingController moneyController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  String message = '';
  bool isLoading = false;

  @override
  void initState() {
   var money = Expense.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
        appBar: AppBar(
         title: const Text('Fund Wallet'),
      ),
      body: Container(

      ),
     );
  }
}
