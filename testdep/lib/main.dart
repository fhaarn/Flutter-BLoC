import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:testdep/apc.dart';
import 'package:testdep/tesbloc.dart';
// import 'package:testdep/tespro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: tesBloc());
  }
}
