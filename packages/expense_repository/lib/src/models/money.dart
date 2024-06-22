
import 'package:expense_repository/src/entities/entities.dart';

class Money {
  String moneyId;
  double amount;
  String userId;


  Money({
    required this.moneyId,
    required this.amount,
    required this.userId,
  });


 static final empty = Money(
  moneyId: '', 
  amount: 0.0, 
  userId: ''
  );

  MoneyEntity toEntity() {
    return MoneyEntity(
      moneyId : moneyId,
      amount: amount,
      userId: userId
    );
  }

  
  static  Money fromEntity(MoneyEntity entity) {
    return Money(
      moneyId :entity.moneyId,
      amount: entity.amount,
      userId: entity.userId
      
    );
  }
}