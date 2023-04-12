import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

import 'package:wallet_app/blocs/blocs.dart';
import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/theme.dart';
import 'package:wallet_app/views/views.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.user, super.key});

  final UserModel user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  UserRepository usersRepository = UserRepository();
  late Box<UserModel> box;
  late UserModel user;
  DateTime selectedDate = DateTime.now();
  bool _yearMode = false;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    box = Hive.box<UserModel>('users_box');
    box.get(widget.user.id) ?? box.put(widget.user.id, widget.user);
    user = box.get(widget.user.id)!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: walletAppTheme.scaffoldBackgroundColor,
      bottomNavigationBar: _bottomNavBar(),
      floatingActionButton: _dialButton(context),
      appBar: _appBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: [
          WalletScreen(
            user: user,
            date: selectedDate,
            onPressedAddAccount: (account) {
              setState(() {
                context.read<UserBloc>().add(
                      UserAddAccountEvent(account),
                    );
              });
            },
            onPressedAddCreditCard: (creditCard) {
              setState(() {
                context.read<UserBloc>().add(
                      UserAddCreditCardEvent(creditCard),
                    );
              });
            },
          ),
          TransactionsScreen(user: user, date: selectedDate),
          StatisticsScreen(user: user, date: selectedDate, yearMode: _yearMode),
        ],
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: walletAppTheme.scaffoldBackgroundColor,
      elevation: 0,
      title: _datePicker(),
    );
  }

  Row _datePicker() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: walletAppTheme.scaffoldBackgroundColor,
            elevation: 0,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            setState(() {
              _yearMode
                  ? selectedDate = selectedDate.subtract(
                      const Duration(days: 365),
                    )
                  : selectedDate = selectedDate.subtract(
                      const Duration(days: 30),
                    );
            });
          },
          child: const Icon(
            FontAwesomeIcons.chevronLeft,
            size: 12,
            color: Colors.grey,
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _yearMode = !_yearMode;
            });
          },
          child: _yearMode
              ? Text(
                  selectedDate.year.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : Text(
                  selectedDate.year == DateTime.now().year
                      ? DateFormat('MMMM').format(selectedDate)
                      : DateFormat('MMMM yyyy').format(selectedDate),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: walletAppTheme.scaffoldBackgroundColor,
            elevation: 0,
            shape: const CircleBorder(),
          ),
          onPressed: () {
            setState(() {
              _yearMode
                  ? selectedDate = selectedDate.add(
                      const Duration(days: 365),
                    )
                  : selectedDate = selectedDate.add(
                      const Duration(days: 30),
                    );
            });
          },
          child: const Icon(
            FontAwesomeIcons.chevronRight,
            size: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  BottomNavBar _bottomNavBar() {
    return BottomNavBar(
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      },
    );
  }

  SpeedDial _dialButton(BuildContext context) {
    return SpeedDial(
      elevation: 0,
      overlayOpacity: 0,
      backgroundColor: primaryColor,
      activeIcon: Icons.close,
      spacing: 3,
      direction: SpeedDialDirection.left,
      children: [
        SpeedDialChild(
          child: const FaIcon(
            FontAwesomeIcons.plus,
            color: Colors.white,
          ),
          backgroundColor: incomeColor,
          onTap: () {
            user.accounts.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please add an account first',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddTransactionScreen.income(
                        user: user,
                        onPressed: (transaction) {
                          setState(() {
                            context.read<UserBloc>().add(
                                  UserEvent.addTransaction(
                                    transaction,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
          },
        ),
        SpeedDialChild(
          child: const FaIcon(
            FontAwesomeIcons.minus,
            color: Colors.white,
          ),
          backgroundColor: expenseColor,
          onTap: () {
            user.accounts.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please add an account first',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddTransactionScreen.expense(
                        user: user,
                        onPressed: (transaction) {
                          setState(() {
                            context.read<UserBloc>().add(
                                  UserEvent.addTransaction(
                                    transaction,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
          },
        ),
        SpeedDialChild(
          child: const FaIcon(
            FontAwesomeIcons.arrowRightArrowLeft,
            color: Colors.white,
          ),
          backgroundColor: transferColor,
          onTap: () {
            user.accounts.length <= 1
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Debes tener 2 cuentas como mínimo para realizar una transferencia',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddTransferScreen(
                        user: user,
                        onPressed: (toAccount, fromAccount) {
                          setState(() {
                            context.read<UserBloc>().add(
                                  UserEvent.addTransaction(
                                    toAccount,
                                  ),
                                );
                            context.read<UserBloc>().add(
                                  UserEvent.addTransaction(
                                    fromAccount,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
          },
        ),
        SpeedDialChild(
          child: const FaIcon(
            FontAwesomeIcons.creditCard,
            color: Colors.white,
          ),
          backgroundColor: expenseColor,
          onTap: () {
            user.creditCards.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Please add a credit card first',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  )
                : Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => AddCreditCardExpenseScreen(
                        user: user,
                        onPressed: (creditCardExpense) {
                          setState(() {
                            context.read<UserBloc>().add(
                                  UserEvent.addCreditCardExpense(
                                    creditCardExpense,
                                  ),
                                );
                          });
                        },
                      ),
                    ),
                  );
          },
        ),
      ],
      child: const FaIcon(
        FontAwesomeIcons.plus,
        color: Colors.white,
      ),
    );
  }
}
