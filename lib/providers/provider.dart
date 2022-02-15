import 'package:flutter/material.dart';
// import 'dart:math';

class InputTextProvider with ChangeNotifier {
  // List<Color> listColors = [
  //   Colors.red,
  //   Colors.green,
  //   Colors.yellow,
  //   Colors.lightBlue,
  //   Colors.lightGreen,
  //   Colors.orange,
  //   Colors.blueGrey,
  //   Colors.grey
  // ];
  // List<Color> colors = [];
  // int random() => Random().nextInt(listColors.length);

  // Map<String, dynamic> mapList = {
  //   'listItems': '',
  //   'titleItems': '',
  //   'colors': '',
  // };
  // List<Map> listMap = [];
  List<String> listItems = [];
  List<String> titleItems = [];
  String inputText = '';
  String titleText = '';

  void newInputText(String newText) {
    inputText = newText;
    notifyListeners();
  }

  void newTitleText(String newtitleText) {
    titleText = newtitleText;
    notifyListeners();
  }

  void clearText() {
    inputText = ' ';
    notifyListeners();
  }

  void clearTitleText() {
    titleText = '';
    notifyListeners();
  }

  void addItem() {
    listItems.add(inputText);
    notifyListeners();
  }

  void addTitleItem() {
    titleItems.add(titleText);
    notifyListeners();
  }
}
