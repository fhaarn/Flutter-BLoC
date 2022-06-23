import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class truckGif extends StatelessWidget {
  const truckGif({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RiveAnimation.network(
      'https://cdn.rive.app/animations/vehicles.riv',
    );
  }
}
