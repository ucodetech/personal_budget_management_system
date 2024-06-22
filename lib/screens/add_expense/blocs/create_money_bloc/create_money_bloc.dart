import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_money_event.dart';
part 'create_money_state.dart';

class CreateMoneyBloc extends Bloc<CreateMoneyEvent, CreateMoneyState> {
  ExpenseRepository expenseRepository;

  CreateMoneyBloc(this.expenseRepository) : super(CreateMoneyInitial()) {
    on<CreateMoney>((event, emit) async {
      emit(CreateMoneyLoading());
      try {
        await expenseRepository.createMoney(event.money);
        emit(CreateMoneySuccess());
      } catch (e) {
        emit(CreateMoneyFailure());
      }
    });
  }
}
