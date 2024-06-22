part of 'create_money_bloc.dart';

sealed class CreateMoneyEvent extends Equatable {
  const CreateMoneyEvent();

  @override
  List<Object> get props => [];
}

class CreateMoney extends CreateMoneyEvent{
  final Money money;

  const CreateMoney(this.money);

  @override
  List<Object> get props => [money];
}