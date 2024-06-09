import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_repository/src/entities/entities.dart';

class FireBaseExpenseRepo implements ExpenseRepository {

  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      // ignore: unrelated_type_equality_checks
     
        await categoryCollection
      .doc(category.categoryId)
      .set(category.toEntity().toDocument());
      
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }


   @override
  Future<List<Category>> getAllCategory() async {
    try {
     return await categoryCollection
      .get()
      .then((value)=> value.docs.map((e) =>
      Category.fromEntity(CategoryEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> categoryExist(String name, String icon) async {
   
    final QuerySnapshot result = await categoryCollection
        .where('name'.toLowerCase(), isEqualTo: name.toLowerCase())
        .where('icon'.toLowerCase(), isEqualTo: icon.toLowerCase())
        .limit(1)
        .get();

    if(result.docs.isNotEmpty){
      return true;
    }else{
      return false;
    }
  
    
  }
  
  @override
  Future<void> createExpense(Expense expense) async {
    try {
     
      await expenseCollection
      .doc(expense.expenseId)
      .set(expense.toEntity().toDocument());
      
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<Expense>> getAllExpense() async {
     try {
     return await expenseCollection
      .get()
      .then((value)=> value.docs.map((e) =>
      Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

}