import 'package:flutter/cupertino.dart';
import 'package:testdep/apc.dart';
import 'package:flutter/material.dart';
import 'package:testdep/color_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';

class tesQr extends StatefulWidget {
  const tesQr({Key? key}) : super(key: key);

  @override
  _tesQrState createState() => _tesQrState();
}

class _tesQrState extends State<tesQr> {
  @override
  ColorBloc bloc = ColorBloc();
  void disopose() {
    bloc.disopose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("generate qr"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: 'Manik No.1',
              version: QrVersions.auto,
              size: 150,
              gapless: true,
            ),
            SizedBox(
              height: 10,
            ),
            QrImage(
              data: 'Manik No.1',
              version: QrVersions.auto,
              size: 320,
              gapless: false,
              embeddedImage: AssetImage('images/abv.png'),
              embeddedImageStyle: QrEmbeddedImageStyle(
                size: Size(80, 80),
              ),
            )
          ],
        ),
      ),
    );
  }
}
