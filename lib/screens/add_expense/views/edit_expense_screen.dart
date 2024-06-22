import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:personal_budget_managemet/widgets/button.dart';

class EditExpenseScreen extends StatefulWidget {
  final Expense expense;

  const EditExpenseScreen(this.expense, {super.key});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _amountController;
  late TextEditingController _dateController;
  late TextEditingController _categoryController;
  late Expense _expense;
  bool _isLoading = false;
  late DateTime _selectDate;
  bool _showCategoryList = false;
  List<Category> _categories = [];

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: widget.expense.amount.toString());
    _dateController = TextEditingController(text: DateFormat('dd/MM/yyyy').format(widget.expense.date));
    _categoryController = TextEditingController(text: widget.expense.category.name);
    _expense = widget.expense;
    _selectDate = widget.expense.date;
    _fetchCategories();
  }

  final expenseCollection = FirebaseFirestore.instance.collection('expenses');
  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final user = FirebaseAuth.instance.currentUser!;

  void _fetchCategories() async {
    final querySnapshot = await categoryCollection
        .where('userId', isEqualTo: user.uid)
        .get();
    setState(() {
      _categories = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Category(
          categoryId: data['categoryId'],
          name: data['name'],
          color: data['color'],
          icon: data['icon'],
          totalExpenses: data['totalExpenses'],
          userId: data['userId']
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Expense'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                     Text(
                      'Update Expense',
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
                        controller: _amountController,
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
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                      ),
                    ),
                    
                      const SizedBox(
                      height: 16,
                    ),

                    TextFormField(
                      controller: _dateController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: _selectDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            _selectDate = pickedDate;
                            _dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                          });
                        }
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Date',
                        prefixIcon: const Icon(FontAwesomeIcons.clock,
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
                    const SizedBox(
                      height: 16,
                    ),
                    //  
                      const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _categoryController,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          _showCategoryList = !_showCategoryList;
                        });
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: _expense.category == Category.empty
                            ? Colors.white
                            : Color(_expense.category.color),
                        hintText: 'Category',
                        prefixIcon: _expense.category == Category.empty
                            ? const Icon(FontAwesomeIcons.list,
                                size: 16, color: Colors.grey)
                            : Image.asset('assets/${_expense.category.icon}.png',
                                scale: 2),
                       
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
                    
                    _showCategoryList
                        ? Container(
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListView.builder(
                                itemCount: _categories.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      onTap: () {
                                        setState(() {
                                          _expense.category = _categories[index];
                                          _categoryController.text = _categories[index].name;
                                          _showCategoryList = false;
                                        });
                                      },
                                      leading: Image.asset('assets/${_categories[index].icon}.png', scale: 2),
                                      title: Text(_categories[index].name),
                                      tileColor: Color(_categories[index].color),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      textColor: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(),
                    const SizedBox(height: 20),
                     SizedBox(
                      child: _isLoading == true
                          ? const Center(child: CircularProgressIndicator(),)
                          :  Button(
                              text: 'Update Expense',
                              icon: Icons.update,
                              onPressed:  _submitForm
                              
                          ),
                      ),
                      
                    // ElevatedButton(
                    //   onPressed: _submitForm,
                    //   child: _isLoading ? const CircularProgressIndicator() : const Text('Update Expense'),
                    // ),
                  ],
                ),
              ),
            ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      _expense.amount = double.parse(_amountController.text);
      _expense.date = _selectDate;

      final querySnapshot = await expenseCollection.where('expenseId', isEqualTo: _expense.expenseId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        final expenseRef = expenseCollection.doc(docId);
        expenseRef.update({
          'amount': _expense.amount,
          'date': _expense.date,
          'category': {
            'categoryId' : _expense.category.categoryId,
            'name': _expense.category.name,
            'color': _expense.category.color,
            'icon': _expense.category.icon,
            'totalExpenses': _expense.category.totalExpenses,
            'userId': _expense.category.userId
          },
        }).then((_) {
          Navigator.of(context).pop(true);
        }).catchError((error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update expense: $error')),
          );
          setState(() {
            _isLoading = false;
          });
        });
      }
    }
  }
}
