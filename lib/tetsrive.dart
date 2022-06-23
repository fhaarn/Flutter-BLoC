import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:testdep/hah/truck.dart';

class tesRive extends StatefulWidget {
  const tesRive({Key? key}) : super(key: key);

  @override
  _tesRiveState createState() => _tesRiveState();
}

class _tesRiveState extends State<tesRive> {
  SMITrigger? _bump;

  void _onRiveInit(Artboard artboard) {
    final controller = StateMachineController.fromArtboard(artboard, 'bumpy');
    artboard.addController(controller!);
    _bump = controller.findInput<bool>('bump') as SMITrigger;
  }

  void _hitBump() => _bump?.fire();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Let's play w/ rive"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 1000,
            child: GestureDetector(
              child: RiveAnimation.network(
                'https://cdn.rive.app/animations/vehicles.riv',
                fit: BoxFit.contain,
                onInit: _onRiveInit,
              ),
              onTap: _hitBump,
            )),
      ),
    );
  }
}
