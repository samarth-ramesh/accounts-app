import 'package:flutter/material.dart';

class ChooseAccount extends StatefulWidget {
  int current;
  final Map<int, String> accounts;
  final Function(int) callback;

  ChooseAccount(
      {Key? key,
      required this.current,
      required this.accounts,
      required this.callback})
      : super(key: key);

  @override
  State<ChooseAccount> createState() => _ChooseAccountState();
}

typedef MenuItemType = DropdownMenuItem<int>;

class _ChooseAccountState extends State<ChooseAccount> {
  List<MenuItemType> _get_items() {
    List<MenuItemType> rv = [];
    rv.add(DropdownMenuItem(
      enabled: false,
      value: -1,
      child: Text("Select Account", style: TextStyle(color: Theme.of(context).disabledColor),),
    ));
    widget.accounts.forEach((key, value) {
      rv.add(DropdownMenuItem(
        value: key,
        child: Text(value),
      ));
    });
    return rv;
  }

  @override
  Widget build(BuildContext context) {
    int cur = widget.current;
    var items = _get_items();
    return DropdownButton<int>(
      items: items,
      onChanged: (int? next) {
        if (next != null) {
          widget.callback(next);
        }
      },
      value: cur,
    );
  }
}
