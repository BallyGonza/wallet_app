import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wallet_app/blocs/blocs.dart';

import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/screens/add_transaction_screen/widgets/widgets.dart';
import 'package:wallet_app/views/views.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({
    required this.user,
    super.key,
  });

  final UserModel user;

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  late InstitutionModel _selectedInstitution;

  @override
  void initState() {
    _selectedInstitution = defaultInstitutions[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Container(
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'New Account',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _saveButton(context),
      body: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: colorCards,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [
                    WalletListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Color(_selectedInstitution.backgroundColor),
                        child: Image(
                          image: AssetImage(_selectedInstitution.logo),
                          height: 25,
                          width: 25,
                        ),
                      ),
                      content: const Text(
                        'Cuenta',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              _selectedInstitution.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            const FaIcon(
                              FontAwesomeIcons.chevronRight,
                              color: Colors.grey,
                              size: 12,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showModalBottomSheet<Padding>(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          backgroundColor: colorCards,
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: const EdgeInsets.all(8),
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.45,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        itemCount: defaultInstitutions.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedInstitution =
                                                    defaultInstitutions[index];
                                              });
                                              Navigator.pop(context);
                                            },
                                            child: InstitutionListItem(
                                              institution:
                                                  defaultInstitutions[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  BottomAppBar _saveButton(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: colorCards,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: widget.user.accounts.any(
                  (element) => element.institution == _selectedInstitution,
                )
                    ? Colors.grey
                    : primaryColor,
              ),
              onPressed: () {
                if (widget.user.accounts.any(
                  (element) => element.institution == _selectedInstitution,
                )) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La cuenta que intenta crear ya existe'),
                    ),
                  );
                  return;
                }

                final account = AccountModel(
                  id: DateTime.now().millisecondsSinceEpoch,
                  institution: _selectedInstitution,
                  name: _selectedInstitution.name,
                );
                context.read<AccountBloc>().add(AccountEvent.add(account));

                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
