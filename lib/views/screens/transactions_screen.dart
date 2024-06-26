import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/blocs/blocs.dart';
import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/views.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({
    required this.date,
    required this.user,
    super.key,
  });

  final DateTime date;
  final UserModel user;

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  late TransactionRepository transactionRepository;

  @override
  void initState() {
    transactionRepository = context.read<TransactionRepository>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: const BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              loaded: (accounts) {
                final transactions = transactionRepository
                    .getAllTransactionsByDate(accounts, widget.date);
                return transactions.isEmpty
                    ? const Center(
                        child: Text(
                          'No transactions yet',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          return TransactionsList(
                            user: widget.user,
                            date: widget.date,
                            day: 31 - index,
                          );
                        },
                      );
              },
            );
          },
        ),
      ),
    );
  }
}
