

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/entities/entities.dart';

import '../models/category.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime date;
  double amount;
  String userId;

  ExpenseEntity({
       required this.expenseId,
        required this.category,
        required this.date,
        required this.amount,
        required this.userId, 
  });

  Map<String, Object?> toDocument() {
     return {
      'expenseId' : expenseId,
      'category' : category.toEntity().toDocument(),
      'date': date,
      'amount': amount,
      'userId': userId
     };
  }

  static ExpenseEntity fromDocument(Map<String, dynamic> doc) {
    return ExpenseEntity(
      expenseId: doc['expenseId'],
      category: Category.fromEntity(CategoryEntity.fromDocument(doc['category'])),
      date: (doc['date'] as Timestamp).toDate(),
      amount: doc['amount'],
      userId: doc['userId']
      
    );
  }
}