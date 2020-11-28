import 'package:flutter/material.dart';
import 'dart:async';
import 'scan.dart' as sc;
import 'package:fluttertoast/fluttertoast.dart';
import 'controllers/coupon.controller.dart';
import 'models/coupon.model.dart';

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
  var _onPressed;
  String _read;

  Future<Coupon> futureCoupon;
  Future<NetworkImage> futureImage;

  Future<Map> getData(String secretId) async {
    var response = CouponController().findById(secretId);
    setState(() {
      futureCoupon = response;
    });
  }

  Future scan() async {
    var scanner = sc.Scanner();
    String read = await scanner.newScan();
    return read;
  }

  @override
  void initState() {
    super.initState();
    futureCoupon = CouponController().findById('c4ca4238a0b923820dcc509a6f75849b');
  }

  _startScan(){
    scan()
        .then((secretId) => getData(secretId));
  }

  _showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Fetch Data Example'),
        ),
        body: Center(
          child: Column(
            children: [
              FutureBuilder<Coupon>(
              future: futureCoupon,
              builder: (context, snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    Icon(
                      Icons.check_circle_outline,
                      color: Colors.green,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Status: ${snapshot.data.status} \n'
                          'Operador: ${snapshot.data.operator} \n'
                          'Litros: ${snapshot.data.liters}\n'
                          'Importe: ${snapshot.data.amount}\n'
                          ''),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Image.network('http://192.168.0.12:9000/storage/vehicles/${snapshot.data.vehicleImageUrl}'),
                    )
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    )
                  ];
                }
                else {
                  children = <Widget>[
                    SizedBox(
                      child: CircularProgressIndicator(),
                      width: 60,
                      height: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    )
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
              ButtonBar(
                children: <Widget>[
                  FlatButton(
                    child: Text('Pay'),
                    color: Colors.blue,
                    onPressed: () { _showToast('Vale pagado'); },
                  ),
                  FlatButton(
                    child: Text('New Scan'),
                    color: Colors.blue,
                    onPressed: _startScan,
                  ),
                ],
              ),
          // Padding(padding: EdgeInsets.all(12), child: ElevatedButton(onPressed: _startScan, child: Text('Scan'),)),
            ],
          ),
        ),
      ),
    );
  }
}
