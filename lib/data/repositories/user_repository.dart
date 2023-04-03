import 'package:wallet_app/data/data.dart';

class UserRepository {
  UserRepository();

  Future<UserModel> getUser() async {
    return user;
  }

  // calculate the total balance of all accounts
  double getTotalBalance(
    List<AccountModel> accounts,
  ) {
    return accounts
        .map((e) => e.balance)
        .reduce((value, element) => value + element);
  }

  // calculate the total income of all accounts
  double getTotalIncome(List<AccountModel> accounts) {
    return accounts
        .map((e) => e.transactions.isEmpty
            ? 0
            : e.transactions
                .where((element) => element.isIncome)
                .map((e) => e.amount)
                .reduce((value, element) => value + element))
        .reduce((value, element) => value + element)
        .toDouble();
  }

  // calculate the total expense of all accounts
  double getTotalExpense(List<AccountModel> accounts) {
    return accounts
        .map((e) => e.transactions.isEmpty
            ? 0
            : e.transactions
                .where((element) => !element.isIncome)
                .map((e) => e.amount)
                .reduce((value, element) => value + element))
        .reduce((value, element) => value + element)
        .toDouble();
  }
}

UserModel user = UserModel(
  id: 0,
  name: 'Gonzalo Bally',
  password: '1234',
  image: '',
  accounts: [...defaultAccounts],
  transactions: [],
  categories: [...defaultCategories],
  creditCards: [],
  tags: [],
);
