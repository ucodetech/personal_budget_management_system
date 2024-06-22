import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';

part 'get_money_event.dart';
part 'get_money_state.dart';

class GetMoneyBloc extends Bloc<GetMoneyEvent, GetMoneyState> {
  ExpenseRepository expenseRepository;
  GetMoneyBloc(this.expenseRepository) : super(GetMoneyInitial()) {
    on<GetMoney>((event, emit) async {
      emit(GetMoneyLoading());
      try {
       final money =  await expenseRepository.getUserMoney(event.userId);
        emit(GetMoneySuccess(money['amount'], money['income']));
      } catch (e) {
        emit(const GetMoneyFailure(error: "Something went wrong"));
      }
    });
  }
}


