import 'package:flutter/material.dart';
import 'package:wallet_app/data/data.dart';

class CreditCardListItem extends StatelessWidget {
  const CreditCardListItem({required this.creditCard, Key? key})
      : super(key: key);

  final CreditCardModel creditCard;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Color(creditCard.institution.backgroundColor),
          radius: 18,
          child: Image.asset(
            creditCard.cardType.logo,
            width: 24,
          ),
        ),
        title: Text(
          creditCard.institution.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        subtitle: Text(
          creditCard.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
