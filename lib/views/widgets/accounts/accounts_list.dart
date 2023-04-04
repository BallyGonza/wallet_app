import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallet_app/blocs/blocs.dart';
import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/views.dart';

class AccountsList extends StatefulWidget {
  const AccountsList({required this.user, Key? key}) : super(key: key);

  final UserModel user;

  @override
  State<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends State<AccountsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state.maybeWhen(
          updated: (updatedAccount) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (_) => AddAccountScreen(
                            //       onPressed: (account) {
                            //         setState(() {
                            //           context.read<AccountBloc>().add(
                            //                 AccountEvent.addAccount(
                            //                     account),
                            //               );
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // );
                          },
                          child: const FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.grey,
                            size: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  BlocConsumer<UserBloc, UserState>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return state.maybeWhen(
                        updated: (user) {
                          return Container(
                            height: user.accounts.length * 73.0,
                            decoration: const BoxDecoration(
                              color: colorCards,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                            ),
                            child: user.accounts.isEmpty
                                ? const Center(
                                    child: Text('No accounts yet'),
                                  )
                                : _buildAccountList(context, user.accounts),
                          );
                        },
                        orElse: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
          orElse: () => const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _buildAccountList(BuildContext context, List<AccountModel> accounts) {
    return ListView(
      reverse: true,
      physics: const NeverScrollableScrollPhysics(),
      children: List.generate(
        accounts.length,
        (index) {
          final account = accounts[index];
          return AccountListItem(
            account: account,
          );
        },
      ),
    );
  }
}
