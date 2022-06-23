import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:testdep/hah/truck.dart';

class tesLazy2 extends StatefulWidget {
  const tesLazy2({Key? key}) : super(key: key);

  @override
  _tesLazy2State createState() => _tesLazy2State();
}

class _tesLazy2State extends State<tesLazy2> {
  static const _itemCount = 1000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("testing lazy single child scroll view"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
            width: 400,
            height: 1000,
            child: ListView.builder(
              itemCount: _itemCount,
              itemBuilder: (context, index) {
                return Container(
                    height: 200,
                    color: Colors.teal.withOpacity(index / _itemCount),
                    child: truckGif());
              },
            )),
      ),
    );
  }
}
