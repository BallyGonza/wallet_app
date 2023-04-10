import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:wallet_app/data/data.dart';

part 'user_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 6)
class UserModel extends HiveObject {
  @HiveField(0)
  int id;
  @HiveField(1)
  List<AccountModel> accounts;
  @HiveField(2)
  List<TransactionModel> transactions;
  @HiveField(3)
  List<CategoryModel> incomeCategories;
  @HiveField(4)
  List<CategoryModel> expenseCategories;
  @HiveField(5)
  List<CreditCardModel> creditCards;
  @HiveField(6)
  List<CreditCardTransactionModel> creditCardExpenses;

  UserModel({
    required this.id,
    required this.accounts,
    required this.transactions,
    required this.incomeCategories,
    required this.expenseCategories,
    required this.creditCards,
    required this.creditCardExpenses,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
