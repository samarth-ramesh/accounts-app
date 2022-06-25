import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart' as http;

class Account {
  String name;
  int id;
  double amount;

  Account({required this.name, required this.amount, required this.id});

  factory Account.fromJSON(Map<String, dynamic> body) {
    return Account(name: body['Name'], amount: body['Amount'], id: body['Id']);
  }
}

Future<List<Account>> getAccountsLong() async {
  final resp = await http.post(Uri.parse("$baseUrl/accounts/list"),
      headers: getHeaders(token), body: '{}');

  if (resp.statusCode != 200) {
    throw resp.statusCode;
  }

  var body = jsonDecode(resp.body);

  var accountList = body['Accounts'];

  var rv = <Account>[];
  accountList.forEach((e) {
    rv.add(Account.fromJSON(e));
  });
  return rv;
}
