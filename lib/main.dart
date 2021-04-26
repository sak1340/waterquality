import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dht.dart';

//import 'showDB.dart';

Future<void> main() async {
  await Firebase.initializeApp();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShowDB(),
      theme: ThemeData(
        primaryColor: Colors.amber, primarySwatch: Colors.deepOrange
      ),
    );
  }
}

class ShowDB extends StatefulWidget {
  @override
  _ShowDBState createState() => _ShowDBState();
}

class _ShowDBState extends State<ShowDB> {

  final DatabaseReference _salRef = FirebaseDatabase.instance.reference().child('DHT');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
      stream: _salRef.onValue,
      builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      !snapshot.hasError &&
                      snapshot.data.snapshot.value != null) {
                    var _dht =
                        DHT.fromJson(snapshot.data.snapshot.value['Json']);
                    print("DHT: ${_dht.ec} / ${_dht.sal} / ${_dht.temp}");
                  } else {
                    return Center(
                      child: Text("NO DATA YET"));
                  }}
    ),
    );
  }
}