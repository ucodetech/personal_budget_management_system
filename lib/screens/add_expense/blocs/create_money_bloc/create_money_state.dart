part of 'create_money_bloc.dart';

sealed class CreateMoneyState extends Equatable {
  const CreateMoneyState();
  
  @override
  List<Object> get props => [];
}

final class CreateMoneyInitial extends CreateMoneyState {}

final class CreateMoneyFailure extends CreateMoneyState {}
final class CreateMoneyLoading extends CreateMoneyState {}
final class CreateMoneySuccess extends CreateMoneyState {}
