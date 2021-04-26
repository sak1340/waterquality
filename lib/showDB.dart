import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dht.dart';

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