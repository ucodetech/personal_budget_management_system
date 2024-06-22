

import 'package:expense_repository/expense_repository.dart';

class Money {
  String moneyId;
  double amount;
  double income;
  String userId;


  Money({
    required this.moneyId,
    required this.amount,
    required this.income,
    required this.userId,
  });


 static final empty = Money(
  moneyId: '', 
  amount: 0.0, 
  income: 0.0,
  userId: ''
  );

  MoneyEntity toEntity() {
    return MoneyEntity(
      moneyId : moneyId,
      amount: amount,
      income: income,
      userId: userId
    );
  }

  
  static  Money fromEntity(MoneyEntity entity) {
    return Money(
      moneyId :entity.moneyId,
      amount: entity.amount,
      income: entity.income,
      userId: entity.userId
      
    );
  }
}