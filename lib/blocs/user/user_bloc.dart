import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/data/data.dart';

import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(const UserState.initial()) {
    on<UserInitialEvent>(_onInit);

    add(const UserEvent.init());
  }

  final UserRepository userRepository = UserRepository();

  late UserModel user;
  late List<CreditCardTransactionModel> creditCardExpenses;

  Future<void> _onInit(
    UserInitialEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserState.loading());
    user = await userRepository.getUser();
    emit(UserState.loaded(user));
  }

  // Future<void> _onPayCreditCard(
  //   UserPayCreditCardEvent event,
  //   Emitter<UserState> emit,
  // ) async {
  //   emit(const UserState.loading());
  //   for (var transaction in event.creditCardExpenses) {
  //     int currentCuota =
  //         (transaction.date.difference(event.date).inDays / 30).round().abs();
  //     if (currentCuota == transaction.cuotas) {
  //       creditCardExpenses
  //           .removeWhere((element) => element.id == transaction.id);
  //       // creditCardExpenses.sort((a, b) => a.date.compareTo(b.date));
  //       user.creditCardExpenses = creditCardExpenses;
  //     }
  //   }
  //   await userRepository.saveUser(user);
  //   emit(UserState.loaded(user));
  // }
}
