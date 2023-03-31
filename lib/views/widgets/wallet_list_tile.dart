import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletListTile extends StatelessWidget {
  const WalletListTile({
    required this.icon,
    required this.content,
    this.trailing,
    this.onTap,
    super.key,
  });

  final IconData icon;
  final Widget content;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap ?? () {},
          child: ListTile(
            leading: FaIcon(icon, color: Colors.grey),
            title: content,
            trailing: trailing ?? const SizedBox.shrink(),
          ),
        ),
        const Divider(color: Colors.black)
      ],
    );
  }
}
