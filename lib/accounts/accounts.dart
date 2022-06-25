import 'package:accounts/accounts/all_accounts.dart';
import 'package:accounts/accounts/create_account.dart';
import 'package:accounts/navbar.dart';
import 'package:flutter/material.dart';

import '../actions/get_accounts_long.dart';

class AccountsPage extends StatefulWidget {
  const AccountsPage({Key? key}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  List<Account> accounts = [];

  void opf(BuildContext context) async {
    Account? acc = await showDialog(
        context: context,
        builder: (BuildContext context) => const CreateAccount());
    if (mounted && acc != null){
      setState((){
        accounts.add(acc);
      });
    }
  }

  @override
  initState() {
    super.initState();
    gaccounts();
  }

  void gaccounts() async {
    var accs = await getAccountsLong();
    setState(() {
      accounts = accs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts"),
      ),
      drawer: const Navbar(),
      body: AccountList(
        accounts: accounts,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          opf(context);
        },
      ),
    );
  }
}

// class AccountsPage extends StatelessWidget {
//   const AccountsPage({Key? key}) : super(key: key);
//

//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Accounts"),
//       ),
//       drawer: const Navbar(),
//       body: const AccountList(),
//       floatingActionButton: FloatingActionButton(
//         child: const Icon(Icons.add),
//         onPressed: () {opf(context);},
//       ),
//     );
//   }
// }
