import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:wallet_app/data/data.dart';
import 'package:wallet_app/views/screens/add_transaction_screen/widgets/widgets.dart';

import 'widgets/widgets.dart';

class AddAccountScreen extends StatefulWidget {
  const AddAccountScreen({
    required this.user,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  final UserModel user;
  final Function(AccountModel) onPressed;

  @override
  State<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  // final TextEditingController _amountController = TextEditingController();

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
              child: Text('New Account', style: TextStyle(fontSize: 16)),
            )),
      ),
      bottomNavigationBar: _saveButton(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       const Text(
          //         'Initial Balance',
          //         style: TextStyle(
          //           fontSize: 16,
          //           fontWeight: FontWeight.normal,
          //           color: Colors.grey,
          //         ),
          //       ),
          //       Row(
          //         children: [
          //           Text(
          //             '\$',
          //             style: TextStyle(
          //               fontSize: 20,
          //               color: transferColor,
          //             ),
          //           ),
          //           const SizedBox(width: 16),
          //           SizedBox(
          //             width: MediaQuery.of(context).size.width - 100,
          //             child: TextFormField(
          //               autofocus: true,
          //               showCursor: false,
          //               decoration: InputDecoration(
          //                 border: InputBorder.none,
          //                 hintText: '0,00',
          //                 hintStyle: TextStyle(
          //                   fontSize: 32,
          //                   fontWeight: FontWeight.bold,
          //                   color: transferColor,
          //                 ),
          //               ),
          //               controller: _amountController,
          //               keyboardType: TextInputType.number,
          //               style: TextStyle(
          //                 fontSize: 32,
          //                 fontWeight: FontWeight.bold,
          //                 color: transferColor,
          //               ),
          //             ),
          //           )
          //         ],
          //       ),
          //     ],
          //   ),
          // ),
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
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  children: [
                    WalletListTile(
                      leading: CircleAvatar(
                        backgroundColor:
                            Color(_selectedInstitution.backgroundColor),
                        child: Image.asset(
                          _selectedInstitution.logo,
                          width: 25,
                          height: 25,
                        ),
                      ),
                      content: const Text(
                        'Instution',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
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
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: defaultInstitutions.length * 90,
                              decoration: const BoxDecoration(
                                color: colorCards,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                    const SizedBox(
                                      height: 20,
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
                backgroundColor: user.accounts.any((element) =>
                        element.institution == _selectedInstitution)
                    ? Colors.grey
                    : transferColor,
              ),
              onPressed: () {
                // if (_amountController.text == '') {
                //   return;
                // }
                if (user.accounts.any(
                    (element) => element.institution == _selectedInstitution)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('La cuenta que intenta crear ya existe'),
                    ),
                  );
                  return;
                }
                setState(() {
                  var account = AccountModel(
                    id: DateTime.now().millisecondsSinceEpoch,
                    institution: _selectedInstitution,
                    name: _selectedInstitution.name,
                  );
                  widget.onPressed(account);
                });
                Navigator.pop(context);
              },
              child: const Text('Save', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }
}
