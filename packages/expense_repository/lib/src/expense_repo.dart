import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository{

  Future<void> createCategory(Category category);
  Future<List<Category>> getAllCategory(String userId);
  Future<bool> categoryExist(String name, String icon);

  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getAllExpense(String userId);

  Future<void> createMoney(Money money);
  Future<Map<String, dynamic>> getUserMoney(String userId);
  Future<Map<String, dynamic>> getCurrentAmount(String userId);
  Future<void> updateExpense(Expense expense);

}