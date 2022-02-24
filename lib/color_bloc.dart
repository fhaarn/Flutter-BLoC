import 'package:flutter/material.dart';
import 'dart:async';

enum ColorEvent { to_lg, to_lb }

class ColorBloc {
  Color _color = Colors.lightGreen;

  StreamController<ColorEvent> _eventController =
      StreamController<ColorEvent>();
  StreamSink<ColorEvent> get eventSink => _eventController.sink;

  final StreamController<Color> _stateController = StreamController<Color>();
  StreamSink<Color> get _stateSink => _stateController.sink;

  Stream<Color> get stateStream => _stateController.stream;

  void _mapEventToState(ColorEvent colorEvent) {
    if (colorEvent == ColorEvent.to_lg)
      _color = Colors.lightGreen;
    else
      _color = Colors.lightBlue;

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
