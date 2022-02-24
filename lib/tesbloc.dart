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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
              backgroundColor: Colors.lightGreen,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_lg);
              }),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_lb);
              }),
        ],
      ),
      appBar: AppBar(
        title: Text("Bloc"),
      ),
      body: Center(
        child: StreamBuilder<Color>(
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
      ),
    );
  }
}
