import 'package:flutter/cupertino.dart';
import 'package:testdep/apc.dart';
import 'package:flutter/material.dart';
import 'package:testdep/color_bloc.dart';

class tesBloc extends StatefulWidget {
  const tesBloc({Key? key}) : super(key: key);

  @override
  _tesBlocState createState() => _tesBlocState();
}

class _tesBlocState extends State<tesBloc> {
  @override
  ColorBloc bloc = ColorBloc();
  void disopose() {
    bloc.disopose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bloc (not using bloc library yet)"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder<Color>(
              stream: bloc.stateStream,
              initialData: Colors.lightGreen,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: 100,
                  height: 100,
                  color: snapshot.data,
                );
              },
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    bloc.eventSink.add(ColorEvent.red);
                  },
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent)),
                    child: Text(
                      "Red",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    bloc.eventSink.add(ColorEvent.green);
                  },
                  child: Container(
                    width: 80,
                    height: 20,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.lightBlueAccent)),
                    child: Text(
                      "Green",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                InkWell(
                  onTap: () {
                    bloc.eventSink.add(ColorEvent.blue);
                  },
                  child: Center(
                    child: Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.lightBlueAccent)),
                      child: Text(
                        "Blue",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
