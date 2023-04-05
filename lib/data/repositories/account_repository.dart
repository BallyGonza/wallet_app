import 'package:wallet_app/data/data.dart';

class AccountRepository {
  AccountRepository();

  Future<List<AccountModel>> getAccounts() async {
    return defaultAccounts;
  }
}

List<AccountModel> defaultAccounts = [
  mercadoPago,
  bbva,
  hsbc,
  cash,
  savingsAccount
];

AccountModel cash = AccountModel(
  id: 0,
  name: 'Efectivo',
  institution: wallet,
);

AccountModel hsbc = AccountModel(
  id: 1,
  name: 'HSBC',
  institution: hsbcInstitution,
);

AccountModel bbva = AccountModel(
  id: 2,
  name: 'BBVA',
  institution: bbvaInstitution,
);

AccountModel mercadoPago = AccountModel(
  id: 3,
  name: 'Mercado Pago',
  institution: mercadoPagoInstitution,
);

AccountModel savingsAccount = AccountModel(
  id: 4,
  name: 'Ahorros',
  institution: savingsInstitution,
);
