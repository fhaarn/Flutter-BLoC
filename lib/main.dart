import 'package:flutter/material.dart';
import 'package:testdep/flutter_image_compress.dart';
import 'package:testdep/kindamain.dart';
import 'package:testdep/lazymain.dart';
// import 'package:provider/provider.dart';
// import 'package:testdep/apc.dart';
import 'package:testdep/tesbloc.dart';
import 'package:testdep/tesqr.dart';
import 'package:testdep/testlazy.dart';
import 'package:testdep/testlazy2.dart';
import 'package:testdep/tetsrive.dart';
// import 'package:testdep/tespro.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/main',
      routes: {
        '/main': ((context) => kindaMain()),
        '/bloc': ((context) => tesBloc()),
        '/qr': ((context) => tesQr()),
        '/not_lazy': ((context) => tesLazy()),
        '/lazy': ((context) => tesLazy2()),
        '/rive-experiment': ((context) => tesRive()),
        '/file-compress': ((context) => ImageCompress()),
        '/lazy lazy': ((context) => lazyMain()),
      },
    );
  }
}
