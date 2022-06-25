import 'package:accounts/actions/delete_transaction.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:flutter/material.dart';

class DeleteTransaction extends StatelessWidget {
  final Transaction transaction;

  const DeleteTransaction({Key? key, required this.transaction})
      : super(key: key);

  void doDelete(BuildContext context) async {
    final status = await deleteTransaction(transaction.id);
    Navigator.of(context).pop(status);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        "Delete Transaction",
        style: Theme.of(context).textTheme.headlineSmall,
        textAlign: TextAlign.center,
      ),
      content: const Text(
        "Warning. You are about to delete a transaction. This cannot be reversed",
        textAlign: TextAlign.justify,
      ),
      actions: [
        ElevatedButton(onPressed: () {Navigator.of(context).pop(null);}, child: const Text("Cancel!")),
        OutlinedButton(
          onPressed: () {},
          child: const Text("OK!"),
        ),
      ],
    );
  }
}
