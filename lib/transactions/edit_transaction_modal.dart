import 'package:accounts/actions/edit_transaction.dart';
import 'package:accounts/actions/get_accounts.dart';
import 'package:accounts/transactions/dropdown_button.dart';
import 'package:flutter/material.dart';

import '../actions/get_transactions.dart';

class EditTransaction extends StatefulWidget {
  final Transaction transaction;

  const EditTransaction({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  final TextEditingController _amtController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  Map<int, String> accountList = {};
  int acc1 = -1;
  int acc2 = -1;

  @override
  void initState() {
    super.initState();
    gaccounts();
    final amt = widget.transaction.amt;
    _amtController.text = amt.toString();
    _remarksController.text = widget.transaction.remarks;
  }

  void gaccounts() async {
    var accList = await getAccounts();
    setState(() {
      accountList = accList;
    });
  }

  int getAccountNumFromAccName(String accName) {
    for (var mapVal in accountList.entries) {
      if (mapVal.value == accName) {
        return mapVal.key;
      }
    }
    return -1;
  }

  int getStateOrDefault(int cur, String accName) {
    if (cur < 0) {
      return getAccountNumFromAccName(accName);
    } else {
      return cur;
    }
  }

  @override
  Widget build(BuildContext context) {
    var curAcc1 = getStateOrDefault(acc1, widget.transaction.acc1);
    var curAcc2 = getStateOrDefault(acc2, widget.transaction.acc2);

    return SimpleDialog(
      titlePadding: const EdgeInsets.all(16),
      title: Text(
        "Edit Transaction",
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("From"),
                      ChooseAccount(
                          current: curAcc1,
                          accounts: accountList,
                          callback: (int x) {
                            setState(() {
                              acc1 = x;
                            });
                          }),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text("To"),
                      ChooseAccount(
                          current: curAcc2,
                          accounts: accountList,
                          callback: (int x) {
                            setState(() {
                              acc2 = x;
                            });
                          })
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  onChanged: (String s) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Amount"),
                  ),
                  keyboardType: TextInputType.number,
                  controller: _amtController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextField(
                  onChanged: (String s) {},
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Remarks"),
                  ),
                  keyboardType: TextInputType.text,
                  controller: _remarksController,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Transaction Time ",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    Text(
                      "${widget.transaction.dateTime.day}/${widget.transaction.dateTime.month}/${widget.transaction.dateTime.year}"
                      " ${widget.transaction.dateTime.hour}:${widget.transaction.dateTime.minute}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  final rv = await edit_transaction(
                    id: widget.transaction.id,
                    acc1: curAcc1,
                    acc2: curAcc2,
                    remarks: _remarksController.text,
                    amount: double.parse(_amtController.text),
                  );
                  if (mounted) {
                    Navigator.of(context).pop(rv);
                  }
                },
                child: Text(
                  "Edit!",
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
