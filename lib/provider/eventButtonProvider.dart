import 'package:flutter/material.dart';

class EventButtonProvider extends ChangeNotifier {
  // bool isPressed = false;
  //
  // bool get getIsPressed => isPressed;
  //
  // void setisPressed(bool value) {
  //   isPressed = value;
  //   notifyListeners();
  // }

  Map<String, bool> _buttonStates = {};

  // Get the button state for a specific event
  bool isButtonPressed(String eventName) {
    return _buttonStates[eventName] ?? false; // Default  to false if not set
  }

  // Set the button state for a specific event
  void pressButton(String eventName) {
    _buttonStates[eventName] = true;
    notifyListeners();
  }
}
