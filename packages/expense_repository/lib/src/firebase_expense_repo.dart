import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FireBaseExpenseRepo implements ExpenseRepository {

  final categoryCollection = FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');
  final moneyCollection = FirebaseFirestore.instance.collection('money');


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
  Future<List<Category>> getAllCategory(String userId) async {
    try {
    return await categoryCollection
          .where('userId', isEqualTo: userId) // Filter by userId
          .get()
          .then((value) => value.docs.map((e) => 
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
         final currentAmount = await getCurrentAmount(expense.userId);
            final newAmount = currentAmount['amount'] - expense.amount;
            final querySnapshot = await moneyCollection.where('userId', isEqualTo: expense.userId).get();
            if (querySnapshot.docs.isNotEmpty) {
              final docId = querySnapshot.docs.first.id;
              await moneyCollection.doc(docId).set({'amount': newAmount}, SetOptions(merge: true));
            }
      await expenseCollection
      .doc(expense.expenseId)
      .set(expense.toEntity().toDocument());
        
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  
  @override
  Future<List<Expense>> getAllExpense(String userId) async {
     try {
     return await expenseCollection
      .where('userId', isEqualTo: userId)
      .get()
      .then((value)=> value.docs.map((e) =>
      Expense.fromEntity(ExpenseEntity.fromDocument(e.data()))
      ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentAmount(String userId) async {
    try {
      final querySnapshot = await moneyCollection.where('userId', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
         return {
          'amount': doc['amount'].toDouble(),
          'income': doc['income'].toDouble()
        };
      } else {
        return {
          'amount': 0.00,
          'income': 0.00
        };
      }
    } catch (e) {
       return {
          'amount': 0.00,
          'income': 0.00
        };
    }
  }

    @override
  Future<void> createMoney(Money money) async {
    try {
      final currentAmount = await getCurrentAmount(money.userId);
        if(currentAmount.isNotEmpty && currentAmount['amount'] != 0.0){
            final newAmount = currentAmount['amount'] + money.amount;
            final income = currentAmount['income'] + money.amount;
           final querySnapshot = await moneyCollection.where('userId', isEqualTo: money.userId).get();
            if (querySnapshot.docs.isNotEmpty) {
              final docId = querySnapshot.docs.first.id;
              await moneyCollection.doc(docId).set({'amount': newAmount, 'income':income}, SetOptions(merge: true));
            }
        }else{
          money.income = money.amount;
          await moneyCollection
          .doc(money.moneyId)
          .set(money.toEntity().toDocument());
        }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  
  @override
  Future<Map<String, dynamic>> getUserMoney(String userId) async {
    try {
      final querySnapshot = await moneyCollection.where('userId', isEqualTo: userId).get();
      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
         return {
          'amount': doc['amount'].toDouble(),
          'income': doc['income'].toDouble()
        };
      } else {
        return {
          'amount': 0.00,
          'income': 0.00
        };
      }
    } catch (e) {
       return {
          'amount': 0.00,
          'income': 0.00
        };
    }
  }

@override
  Future<void> updateExpense(Expense expense) async {
    try {
        final querySnapshot = await expenseCollection.where('expenseId', isEqualTo: expense.expenseId).get();
          if (querySnapshot.docs.isNotEmpty) {
            final docId = querySnapshot.docs.first.id;
            await expenseCollection.doc(docId).set({'amount': expense.amount, 'date':expense.date, 'category':expense.category}, 
            SetOptions(merge: true));
          }
    } catch (e) {
      throw Exception('Error updating expense: $e');
    }
  }

}