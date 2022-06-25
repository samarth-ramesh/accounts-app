import 'package:accounts/actions/create_account.dart';
import 'package:accounts/actions/get_accounts_long.dart';
import 'package:accounts/transactions/add_transaction_modal.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String name = "";

  void opf(BuildContext context) async {
    if (name == "") {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            const ErrorDialog(message: "Name yer account matey"),
      );
      return;
    }
    Account acc = await createAccount(name);
    if (mounted){
      Navigator.of(context).pop(acc);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Text(
        "Create Account",
        textAlign: TextAlign.center,
      ),
      titlePadding: const EdgeInsets.all(16),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                onChanged: (String s) {
                  setState((){
                    name = s;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Account Name"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                    onPressed: () {opf(context);}, child: const Text("Create!")),
              )
            ],
          ),
        )
      ],
    );
  }
}
