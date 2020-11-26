import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'api.service.dart' as api;
import 'scan.dart' as sc;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Scan BarCode and QR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _read;
  Map coupon = {'operator': '', 'liters': '', 'amount': ''};

  Future<Map> getData(String secret_id) async {
    var service = api.ApiService();
    Map response = await service.getCoupon(secret_id);
    setState(() {
      coupon = response;
    });
  }

  Future scan() async {
    var scanner = sc.Scanner();
    String read = await scanner.newScan();
    return read;
  }

  _incrementCounter(){
    scan()
        .then((secret_id) => getData(secret_id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Operador:',
            ),
            Text(
              "${coupon['operator']}",
            ),
            Text('Liters'),
            Text(
              "${coupon['liters']}",
            ),
            Text('Amount'),
            Text(
              "${coupon['amount']}",
            ),
            Text('Status'),
            Text(
              "${coupon['status']}",
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.settings_overscan),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
