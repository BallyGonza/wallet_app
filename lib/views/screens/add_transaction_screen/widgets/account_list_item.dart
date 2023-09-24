import 'package:flutter/material.dart';
import 'package:wallet_app/data/data.dart';

class AccountListItem extends StatefulWidget {
  const AccountListItem({
    required this.account,
    super.key,
  });

  final AccountModel account;

  @override
  State<AccountListItem> createState() => _AccountListItemState();
}

class _AccountListItemState extends State<AccountListItem> {
  UserRepository userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(widget.account.institution.backgroundColor),
          radius: 18,
          child: Image(
            image: AssetImage(
              widget.account.institution.logo,
            ),
            height: 25,
            width: 25,
          ),
        ),
        title: Text(
          widget.account.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
