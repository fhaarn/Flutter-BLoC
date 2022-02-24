import 'package:flutter/material.dart';
import 'dart:async';

enum ColorEvent { red, green, blue }

class ColorBloc {
  Color _color = Colors.red;

  final StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  final StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink;

  Stream<Color> get stateStream => _stateController.stream;

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.red)
      _color = Colors.red;
    else if (colorEvent == ColorEvent.green)
      _color = Colors.green;
    else
      _color = Colors.blue;

    _stateSink.add(_color);
  }

  ColorBloc() {
    _eventController.stream.listen(_mapEventToState);
  }

  void disopose() {
    _eventController.close();
    _stateController.close();
  }
}
