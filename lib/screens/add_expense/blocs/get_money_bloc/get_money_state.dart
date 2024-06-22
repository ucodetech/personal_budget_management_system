part of 'get_money_bloc.dart';

sealed class GetMoneyState extends Equatable {
  const GetMoneyState();
  
  @override
  List<Object> get props => [];
}

final class GetMoneyInitial extends GetMoneyState {}

final class GetMoneyLoading extends GetMoneyState {}
final class GetMoneySuccess extends GetMoneyState {
  final double amount;
  final double income;

  const GetMoneySuccess(this.amount, this.income);

  @override
  List<Object> get props => [amount, income];
  
}


class GetMoneyFailure extends GetMoneyState {
  final String error;

  const GetMoneyFailure({required this.error});

  @override
  List<Object> get props => [error];
}

