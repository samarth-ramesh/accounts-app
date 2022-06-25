import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/navbar.dart';
import 'package:accounts/transactions/add_transaction_modal.dart';
import 'package:accounts/transactions/delete_transaction.dart';
import 'package:accounts/transactions/edit_transaction_modal.dart';
import 'package:accounts/transactions/transaction_item.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Transaction> transactions = [];
  Transaction? selected;

  @override
  initState() {
    super.initState();
    getTrans();
  }

  void getTrans() async {
    var trans = await getTransactions();
    setState(() {
      transactions = trans;
    });
  }

  void opf() async {
    Transaction? newTrans = await showDialog(
        context: context,
        builder: (BuildContext ctx) => const AddTransactionModal());
    if (newTrans != null && mounted) {
      setState(() {
        transactions.add(newTrans);
      });
    }
  }

  void select(Transaction? t) {
    setState(() {
      selected = t;
    });
  }

  void handleEdit() async {
    Transaction? result = await showDialog(
        context: context,
        builder: (context) => EditTransaction(transaction: selected!));
    if (result != null) {
      setState(() {
        for (Transaction t in transactions) {
          if (t.id == result.id) {
            transactions[transactions.indexOf(t)] = result;
            break;
          }
        }
      });
    }
    setState(() {
      selected = null;
    });
  }

  void handleDelete() async {
    showDialog(context: context, builder: (context) => DeleteTransaction(transaction: selected!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: selected == null ? const Text("Transactions") : null,
        actions: (selected == null
            ? []
            : [
                IconButton(onPressed: handleEdit, icon: const Icon(Icons.edit)),
                IconButton(onPressed: handleDelete, icon: const Icon(Icons.delete)),
              ]),
        leading: (selected != null)
            ? IconButton(
                onPressed: () {
                  select(null);
                },
                icon: const Icon(Icons.close))
            : null,
      ),
      body: ListView(
        children: List.from(transactions.map((e) => TransactionItem(
              t: e,
              setSelected: select,
              selected: selected?.id == e.id,
              key: Key(e.id.toString()),
            ))),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: opf,
        child: const Icon(Icons.add),
      ),
    );
  }
}
