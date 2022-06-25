import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  const Navbar({Key? key}) : super(key: key);

  void opf(BuildContext context, String rt) {
    Navigator.of(context).pushNamed(rt);
  }

  @override
  Widget build(BuildContext context) {
    var curPath = ModalRoute.of(context)?.settings.name;

    bool canDisable = false;
    if (curPath != null) {
      canDisable = true;
    }

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              "Accounts",
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
          ),
          TextButton(
            onPressed: (canDisable && (curPath == "/transactions")
                ? null
                : () {
                    opf(context, "/transactions");
                  }),
            child: const Text("Transactions"),
          ),
          TextButton(
              onPressed: (canDisable && (curPath == "/accounts")
                  ? null
                  : () {
                      opf(context, "/accounts");
                    }),
              child: const Text("Accounts"))
        ],
      ),
    );
  }
}
