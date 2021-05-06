import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Map currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies[1]));
}

class MyApp extends StatelessWidget {
  final Map _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: defaultTargetPlatform == TargetPlatform.iOS
            ? Colors.grey[100]
            : null,
      ),
      home: new HomePage(_currencies),
    );
  }
}

Future<Map> getCurrencies() async {
  String cryptoUrl =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  http.Response response = await http.get(Uri.parse(cryptoUrl), headers: {
    'Accept': 'application/json',
    'X-CMC_PRO_API_KEY': 'a929f22c-8804-4bf6-8857-cbe421043eb9'
  });
  return json.decode(response.body);
}
