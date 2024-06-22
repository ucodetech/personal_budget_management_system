import 'package:expense_repository/src/models/category.dart';
import 'package:expense_repository/src/models/money.dart';

abstract class ExpenseRepository{

  Future<void> createCategory(Category category);
  Future<List<Category>> getAllCategory();
  Future<bool> categoryExist(String name, String icon);

  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getAllExpense();

  Future<void> createMoney(Money money);
  Future<List<Money>> getAllMoney();

}