import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallet_app/blocs/blocs.dart';

import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/views.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem({
    required this.user,
    required this.transaction,
    super.key,
  });

  final TransactionModel transaction;
  final UserModel user;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController amountController =
        TextEditingController(text: widget.transaction.amount.toString());
    final TextEditingController noteController =
        TextEditingController(text: widget.transaction.note);
    final AccountRepository accountRepository = AccountRepository();
    final account = accountRepository.getAccountOfTransaction(
        widget.user, widget.transaction)!;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          backgroundColor: appBackgroundColor,
          context: context,
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  DescriptionItem(
                    title: 'Category',
                    icon: widget.transaction.category.icon,
                    iconColor: widget.transaction.category.iconColor,
                    backgroundColor:
                        widget.transaction.category.backgroundColor,
                    description: widget.transaction.category.name,
                    transaction: widget.transaction,
                  ),
                  DescriptionItem(
                    title: 'Account',
                    icon: account.institution.logo,
                    backgroundColor: account.institution.backgroundColor,
                    description: account.name,
                    transaction: widget.transaction,
                  ),
                  DescriptionItem(
                    title: 'Amount',
                    icon: 'assets/icons/coin.png',
                    backgroundColor: yellow,
                    description: widget.transaction.category.name == 'Ahorros'
                        ? dolar.format(
                            widget.transaction.amount,
                          )
                        : arg.format(
                            widget.transaction.amount,
                          ),
                    descriptionColor: widget.transaction.category.isIncome
                        ? incomeColor
                        : expenseColor,
                    transaction: widget.transaction,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => WalletAlertDialog(
                          title: 'Editar monto',
                          content: WalletDialogTextField(
                            hint: 'Amount',
                            controller: amountController..text,
                          ),
                          primaryActionTitle: 'Save',
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              context.read<AccountBloc>().add(
                                    AccountEvent.updateTransaction(
                                      account,
                                      widget.transaction.copyWith(
                                        amount: double.parse(
                                          amountController.text
                                              .replaceAll(',', '.'),
                                        ),
                                      ),
                                    ),
                                  );
                            });
                          },
                        ),
                      );
                    },
                  ),
                  DescriptionItem(
                    title: 'Date',
                    icon: 'assets/icons/calendar.png',
                    backgroundColor: white,
                    description: dateFormat.format(widget.transaction.date),
                    transaction: widget.transaction,
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: Column(
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,
                                  child: CupertinoDatePicker(
                                    initialDateTime: widget.transaction.date,
                                    onDateTimeChanged: (DateTime newDate) {
                                      context.read<AccountBloc>().add(
                                            AccountEvent.updateTransaction(
                                              account,
                                              widget.transaction.copyWith(
                                                date: newDate,
                                              ),
                                            ),
                                          );
                                    },
                                    mode: CupertinoDatePickerMode.date,
                                  ),
                                ),
                                ActionButton(
                                  color: Colors.blue,
                                  text: 'Save',
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                  DescriptionItem(
                    title: 'Note',
                    icon: 'assets/icons/pencil.png',
                    backgroundColor: white,
                    description: widget.transaction.note.isEmpty
                        ? 'None'
                        : widget.transaction.note,
                    transaction: widget.transaction,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => WalletAlertDialog(
                          title: 'Editar nota',
                          content: WalletDialogTextField(
                            hint: 'Note',
                            controller: noteController..text,
                          ),
                          primaryActionTitle: 'Save',
                          onPressed: () {
                            Navigator.of(context).pop();
                            setState(() {
                              context.read<AccountBloc>().add(
                                    AccountEvent.updateTransaction(
                                      account,
                                      widget.transaction.copyWith(
                                        note: noteController.text,
                                      ),
                                    ),
                                  );
                            });
                          },
                        ),
                      );
                    },
                  ),
                  const Spacer(),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {
                        context.read<AccountBloc>().add(
                            AccountEvent.removeTransaction(
                                account, widget.transaction));
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
                  Color(widget.transaction.category.backgroundColor),
              child: Image(
                image: AssetImage(widget.transaction.category.icon),
                height: 25,
                width: 25,
                color: widget.transaction.category.iconColor == null
                    ? null
                    : Color(widget.transaction.category.iconColor!),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: widget.transaction.category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      const WidgetSpan(
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                          child: FaIcon(
                            FontAwesomeIcons.arrowRight,
                            size: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: account.name,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.transaction.note == ''
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          const SizedBox(height: 1),
                          Text(
                            widget.transaction.note,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 1),
                        ],
                      ),
              ],
            ),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.transaction.category.name == 'Ahorros'
                      ? dolar.format(
                          widget.transaction.amount,
                        )
                      : arg.format(
                          widget.transaction.amount,
                        ),
                  style: TextStyle(
                    color: widget.transaction.category.isIncome
                        ? Colors.green
                        : Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  dateFormat.format(widget.transaction.date),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DescriptionItem extends StatelessWidget {
  const DescriptionItem({
    Key? key,
    required this.title,
    required this.icon,
    this.iconColor,
    required this.backgroundColor,
    required this.description,
    this.descriptionColor,
    required this.transaction,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String icon;
  final int? iconColor;
  final int backgroundColor;
  final String description;
  final Color? descriptionColor;
  final TransactionModel transaction;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(backgroundColor),
                  child: Image(
                    image: AssetImage(icon),
                    height: 25,
                    width: 25,
                    color: iconColor != null ? Color(iconColor!) : null,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(
                color: descriptionColor ?? Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
