import 'package:expense_repository/expense_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_expense_bloc/create_expense_bloc.dart';
import 'package:personal_budget_managemet/screens/add_expense/blocs/create_money_bloc/create_money_bloc.dart';
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

  String message = '';
  late Money money;
  bool isLoading = false;

  @override
  void initState() {
    money = Money.empty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateMoneyBloc, CreateMoneyState>(
      listener: (context, state) {
        if(state is CreateMoneySuccess){
           setState(() {
             money = Money.empty;
             message = "Money Added!";
           });
          Navigator.pop(context, money);
        }else if(state is CreateMoneyLoading){
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar:
              AppBar(backgroundColor: Theme.of(context).colorScheme.surface),
          body: BlocBuilder<GetCategoriesBloc, GetCategoriesState>(
              builder: (context, state) {
            if (state is GetCategoriesSuccess) {
              var money = state.money;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Fund Wallet',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: TextFormField(
                        controller: moneyController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Amount',
                          prefixIcon: const Icon(FontAwesomeIcons.nairaSign,
                              size: 16, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: const BorderSide(
                              color: Color.fromARGB(255, 65, 19, 73),
                              width: 2.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                  255, 148, 2, 2), // Border color when focused
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors
                                  .red, // Border color when there is an error
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                   
                     SizedBox(
                      child: isLoading == true
                          ? const Center(child: CircularProgressIndicator(),)
                          :  Button(
                              text: 'Fund wallet',
                              icon: Icons.money_off,
                              onPressed: () {
                                // Your save action here
                                setState(() {
                                  money.moneyId = const Uuid().v1();
                                  money.amount = double.parse(moneyController.text);
                                  money.userId = const Uuid().v4();
                                });
                              context.read<CreateMoneyBloc>().add(CreateMoney(money));
                            }
                          // Navigator.pop(context);
                          ),
                      ),
                      
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
        ),
      ),
    );
  }
}
