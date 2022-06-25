import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart';

Future<Transaction> edit_transaction(
    {required int id,
    required int acc1,
    required int acc2,
    required String remarks,
    required double amount}) async {
  Map<String, dynamic> bodyM = {
    'Id': id,
    'A1': acc1,
    'A2': acc2,
    'Amount': amount,
    'Remarks': remarks
  };
  print(bodyM);
  final resp = await patch(Uri.parse("$baseUrl/transactions/edit"), headers: getHeaders(token), body: jsonEncode(bodyM));
  if (resp.statusCode != 200){
    print(resp.body);
    throw resp.statusCode;
  }
  Transaction tx = Transaction.fromJson(jsonDecode(resp.body));
  return tx;
}
