part of 'get_money_bloc.dart';

sealed class GetMoneyEvent extends Equatable {
  const GetMoneyEvent();

  @override
  List<Object> get props => [];
}

class GetMoney extends GetMoneyEvent {
  final String userId;

  const GetMoney(this.userId);

  @override
  List<Object> get props => [userId];
}