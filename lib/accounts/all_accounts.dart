import 'package:accounts/accounts/account_item.dart';
import 'package:accounts/actions/get_accounts_long.dart';
import 'package:flutter/material.dart';

class AccountList extends StatelessWidget {
  final List<Account> accounts;

  const AccountList({Key? key, required this.accounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.from(accounts.map((e) => AccountItem(acc: e))),
    );
  }
}

// class AccountList extends StatefulWidget {
//   const AccountList({Key? key}) : super(key: key);
//
//   @override
//   State<AccountList> createState() => _AccountListState();
// }
//
// class _AccountListState extends State<AccountList> {
//
//   List<Account> accountList = [];
//   @override
//   initState(){
//     super.initState();
//     gaccounts();
//   }
//
//   void gaccounts() async {
//     var accs = await getAccountsLong();
//     setState((){
//       accountList = accs;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView(
//       children: List.from(accountList.map((e) => AccountItem(acc: e))),
//     );
//   }
// }
