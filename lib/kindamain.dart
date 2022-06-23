import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:testdep/hah/truck.dart';

class kindaMain extends StatefulWidget {
  const kindaMain({Key? key}) : super(key: key);

  @override
  _kindaMainState createState() => _kindaMainState();
}

class _kindaMainState extends State<kindaMain> {
  List<String> pageList = [
    '/bloc',
    '/qr',
    '/not_lazy',
    '/lazy',
    '/rive-experiment',
    '/file-compress',
    '/lazy lazy'
  ];
  List<String> name = [
    'bloc',
    'qr',
    'not implemented lazy',
    'lazy',
    'rive experiment',
    'file compress',
    'lazy'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("kinda main bro"),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < pageList.length; i++)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () => Navigator.pushNamed(context, pageList[i]),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        border: Border.all(color: Colors.blueGrey, width: 1),
                      ),
                      child: Center(child: Text(name[i])),
                    ),
                  ),
                ),

              // containedbutton(
              //   onPressed: () {
              //     Navigator.pushNamed(context, '/login');
              //   },
              //   child: Text(
              //     'Sign In',
              //     style: TextStyle(
              //       fontSize: 20,
              //       color: Colors.grey,
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
