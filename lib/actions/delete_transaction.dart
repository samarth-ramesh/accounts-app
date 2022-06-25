import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart';

Future<bool> deleteTransaction(int transactionId) async {
  final bodyM = {
    'Id': transactionId
  };
  final resp =  await post(Uri.parse("$baseUrl/transactions/delete"), headers: getHeaders(token), body: jsonEncode(bodyM));
  if (resp.statusCode != 200){
    throw resp.statusCode;
  }
  final respBody = jsonDecode(resp.body);
  return respBody['Status'];
}