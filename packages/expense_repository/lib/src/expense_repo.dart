import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository{

  Future<void> createCategory(Category category);
  Future<List<Category>> getAllCategory();
  Future<bool> categoryExist(String name, String icon);

  Future<void> createExpense(Expense expense);
  Future<List<Expense>> getAllExpense();


}