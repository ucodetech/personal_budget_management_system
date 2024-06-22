

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/src/entities/entities.dart';


class MoneyEntity {
  String moneyId;
  double amount;
  String userId;

  MoneyEntity({
       required this.moneyId,
        required this.amount,
        required this.userId, 
  });

  Map<String, Object?> toDocument() {
     return {
      'moneyId' : moneyId,
      'amount': amount,
      'userId': userId
     };
  }

  static MoneyEntity fromDocument(Map<String, dynamic> doc) {
    return MoneyEntity(
      moneyId: doc['moneyId'],
      amount: doc['amount'],
      userId: doc['userId']
      
    );
  }
}