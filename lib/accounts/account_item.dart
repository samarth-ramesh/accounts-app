import 'package:flutter/material.dart';

import '../actions/get_accounts_long.dart';

class AccountItem extends StatelessWidget {
  final Account acc;

  const AccountItem({Key? key, required this.acc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    "A/c ",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Text(
                  acc.name,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            Row(
              children: [
                const Text("Bal: "),
                Text(
                  "₹",
                  style: Theme.of(context).textTheme.headline5,
                ),
                Text(
                  acc.amount.toString(),
                  style: Theme.of(context).textTheme.headline5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
