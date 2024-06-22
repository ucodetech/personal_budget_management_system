part of 'get_expenses_bloc.dart';

sealed class GetExpensesEvent extends Equatable {
  const GetExpensesEvent();

  @override
  List<Object> get props => [];
}

class GetExpenses extends GetExpensesEvent{
  final String userId;

  const GetExpenses(this.userId);

  @override
  List<Object> get props => [userId];
}
