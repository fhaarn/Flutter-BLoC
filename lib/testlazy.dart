import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:testdep/hah/truck.dart';

class tesLazy extends StatefulWidget {
  const tesLazy({Key? key}) : super(key: key);

  @override
  _tesLazyState createState() => _tesLazyState();
}

class _tesLazyState extends State<tesLazy> {
  static const _itemCount = 200;

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
          child: SingleChildScrollView(
              child: Column(
            children: <Widget>[
              for (int i = 0; i < _itemCount; i++)
                Container(
                    height: 200,
                    color: Colors.teal.withOpacity(i / _itemCount),
                    child: truckGif())
            ],
          )),
        ),
      ),
    );
  }
}
