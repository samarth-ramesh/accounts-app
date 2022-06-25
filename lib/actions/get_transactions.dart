import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart' as http;
class Transaction {
  String remarks;

  // String acc1;
  String acc2;
  String acc1;
  DateTime dateTime;
  double amt;
  int id;

  Transaction(
      {required this.remarks,
      required this.acc1,
      required this.acc2,
      required this.dateTime,
      required this.amt,
      required this.id});

  factory Transaction.fromJson(Map<String, dynamic> body) {
    var curDT =
        DateTime.fromMillisecondsSinceEpoch(body['TransactionTime']* 1000);
    return Transaction(
        remarks: body['Remarks'],
        acc1: body['Account1'],
        acc2: body['Account2'],
        dateTime: curDT,
        amt: body['Amount'],
        id: body['Id']);
  }
}

Map<String, String> getHeaders(String tk) {
  return {
    "Authorization": "Bearer $tk",
    "Content-Type" : "application/json",
    "accept": "application/json"
  };
}

Future<List<Transaction>> getTransactions() async {
  final resp = await http.post(Uri.parse("$baseUrl/transactions/list"), headers: getHeaders(token), body: '{}');
  if (resp.statusCode != 200) {
    throw resp.statusCode;
  }
  var d = jsonDecode(resp.body);
  var transactions = d['Transactions'];
  var rv = <Transaction>[];
  transactions.forEach((e) {
    rv.add(Transaction.fromJson(e));
  });
  return rv;
}
