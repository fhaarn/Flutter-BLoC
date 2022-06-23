import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:flutter/cupertino.dart';
import 'package:testdep/apc.dart';
import 'package:flutter/material.dart';
import 'package:testdep/color_bloc.dart';
import 'package:testdep/hah/truck.dart';
import 'package:testdep/testlazy.dart';
import 'package:testdep/testlazy2.dart';

class lazyMain extends StatefulWidget {
  const lazyMain({Key? key}) : super(key: key);

  @override
  _lazyMainState createState() => _lazyMainState();
}

class _lazyMainState extends State<lazyMain> {
  @override
  final pages = [
    Container(
      width: 400,
      height: 1000,
      child: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          for (int i = 0; i < 30; i++)
            Container(
                height: 200,
                color: Colors.teal.withOpacity(i / 30),
                child: truckGif())
        ],
      )),
    ),
    Container(
        width: 400,
        height: 1000,
        child: ListView.builder(
          itemCount: 50,
          itemBuilder: (context, index) {
            return Container(
                height: 200,
                color: Colors.teal.withOpacity(index / 50),
                child: truckGif());
          },
        )),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc (not using bloc library yet)"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Builder(builder: (context) => LiquidSwipe(pages: pages)),
    );
  }
}
