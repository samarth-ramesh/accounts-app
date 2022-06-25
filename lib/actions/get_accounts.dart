import 'dart:convert';

import 'package:accounts/actions/bearer_token.dart';
import 'package:accounts/actions/get_transactions.dart';
import 'package:accounts/actions/login.dart';
import 'package:http/http.dart' as http;

Map<int, String>? cur;

Future<Map<int, String>> getAccounts() async {
  if (cur != null){
    return cur as Map<int, String>;
  }
  final resp = await http.post(Uri.parse("$baseUrl/accounts/list"), headers: getHeaders(token), body: '{}');
  
  if (resp.statusCode != 200){
    throw resp.statusCode;
  }

  var body = jsonDecode(resp.body);

  var accountList = body['Accounts'];

  var rv = <int, String>{};

  accountList.forEach((e){
    rv[e['Id']] = e['Name'];
  });
  cur = rv;
  return rv;
}