import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart';

Future<Transaction> createTransaction(
    String remarks, int a1, int a2, double amt) async {
  var body = <String, dynamic>{
    "Amount": amt,
    "Remarks": remarks,
    "A1": a1,
    "A2": a2
  };
  final resp = await post(Uri.parse("$baseUrl/transactions/create"),
      headers: getHeaders(token), body: jsonEncode(body));
  if (resp.statusCode != 200) {
    throw resp.statusCode;
  } else {
    var data = jsonDecode(resp.body);
    var newId = data['Id'];
    return Transaction(
        remarks: remarks,
        acc1: a1.toString(),
        acc2: a2.toString(),
        dateTime: DateTime.now().toUtc(),
        amt: amt,
        id: newId);
  }
}
