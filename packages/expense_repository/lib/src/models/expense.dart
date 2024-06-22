

import 'package:expense_repository/expense_repository.dart';

class Expense {
  String expenseId;
  Category category;
  DateTime date;
  double amount;
  String userId;


  Expense({
    required this.expenseId,
    required this.category,
    required this.date,
    required this.amount,
    required this.userId,
  });


 static final empty = Expense(
  expenseId: '', 
  category: Category.empty, 
  date: DateTime.now(), 
  amount: 0.0, 
  userId: ''
  );

  ExpenseEntity toEntity() {
    return ExpenseEntity(
      expenseId : expenseId,
      category : category,
      date: date,
      amount: amount,
      userId: userId
    );
  }

  
  static  Expense fromEntity(ExpenseEntity entity) {
    return Expense(
      expenseId :entity.expenseId,
      category : entity.category,
      date: entity.date,
      amount: entity.amount,
      userId: entity.userId
      
    );
  }
}