import 'package:accounts/actions/create_transaction.dart';
import 'package:accounts/actions/get_accounts.dart';
import 'package:accounts/transactions/dropdown_button.dart';
import 'package:flutter/material.dart';

class AddTransactionModal extends StatefulWidget {
  const AddTransactionModal({Key? key}) : super(key: key);

  @override
  State<AddTransactionModal> createState() => _AddTransactionModalState();
}

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Error"),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Ok"))
      ],
    );
  }
}

class _AddTransactionModalState extends State<AddTransactionModal> {
  int s1 = -1;
  int s2 = -1;
  double amt = -1;
  String remarks = "";
  Map<int, String> accounts = {};

  void sets1(int s) {
    setState(() {
      s1 = s;
    });
  }

  void sets2(int s) {
    setState(() {
      s2 = s;
    });
  }

  @override
  initState() {
    super.initState();
    gaccounts();
  }

  void gaccounts() async {
    var acc = await getAccounts();
    setState(() {
      accounts = acc;
    });
  }

  void createTrans() async {
    if (s1 < 0 || s2 < 0) {
      // either source or dest have not been selected;
      showDialog(
          context: context,
          builder: (context) =>
              const ErrorDialog(message: "Try choosing an account first!"));
      return;
    }

    if (s1 == s2) {
      // source is same as dest
      showDialog(
          context: context,
          builder: (context) => const ErrorDialog(
              message:
                  "Try sending dough between different accounts you loon!"));
      return;
    }

    if (amt < 0) {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialog(
              message: "Send positive amounts of money only!"));
      return;
    }

    if (remarks == "") {
      showDialog(
          context: context,
          builder: (context) => const ErrorDialog(message: "Comments Please!"));
      return;
    }

    var newTrans = await createTransaction(remarks, s1, s2, amt);
    var accName1 = accounts[int.parse(newTrans.acc1)];
    var accName2 = accounts[int.parse(newTrans.acc2)];
    if (accName1 != null) {
      newTrans.acc1 = accName1;
    }
    if (accName2 != null) {
      newTrans.acc2 = accName2;
    }
    if (mounted) {
      Navigator.of(context).pop(newTrans);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        "Create Transactions",
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.all(8),
      children: [
        Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("From"),
                          ChooseAccount(
                            current: s1,
                            accounts: accounts,
                            callback: sets1,
                          ),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text("To"),
                        ChooseAccount(
                            current: s2, accounts: accounts, callback: sets2)
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text("Amount"), border: OutlineInputBorder()),
                    onChanged: (String s) {
                      setState(() {
                        amt = double.parse(s);
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: TextField(
                    onChanged: (String s) {
                      setState(() {
                        remarks = s;
                      });
                    },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), label: Text("Remarks")),
                    keyboardType: TextInputType.text,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: ElevatedButton(
                      onPressed: () {
                        createTrans();
                      },
                      child: const Text("Create!")),
                )
              ],
            ))
      ],
    );
  }
}
