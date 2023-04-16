import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallet_app/blocs/blocs.dart';
import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/views.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({
    Key? key,
    required this.date,
    required this.user,
  }) : super(key: key);

  final DateTime date;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
          color: colorCards,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return state.maybeWhen(
              orElse: () => const Center(child: CircularProgressIndicator()),
              loaded: (transactions) {
                return transactions.isEmpty
                    ? const Center(
                        child: Text('No transactions yet',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      )
                    : ListView.builder(
                        itemCount: 31,
                        itemBuilder: (context, index) {
                          return TransactionsList(
                            user: user,
                            date: date,
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
