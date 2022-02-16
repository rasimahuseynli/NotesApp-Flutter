import 'package:flutter/material.dart';

class InputTextProvider with ChangeNotifier {
  List<String> listItems = [];
  List<String> titleItems = [];

  final Map<int, String> _titleMap = <int, String>{};

  String _titleValue = '';
  String _inputValue = '';
  int _currentIndex = 0;
  bool _isUpdate = false;

  set titleValue(String value) {
    _titleValue = value;
    notifyListeners();
  }

  void addTitleMap(String value) {
    final titleMapLenght = _titleMap.keys.length;
    final titleIndex = titleMapLenght + 1;

    final body = {
      titleIndex: value,
    };

    _titleMap.addAll(body);

    // print(_titleMap.keys);

    notifyListeners();
  }

  Map<int, String> get titleMap => _titleMap;

  set inputValue(String value) {
    _inputValue = value;
    notifyListeners();
  }

  set currentIndex(int value) {
    _currentIndex = value;
    notifyListeners();
  }

  set isUpdate(bool value) {
    _isUpdate = value;
    notifyListeners();
  }

  String get titleValue => _titleValue;
  String get inputValue => _inputValue;
  int get currentIndex => _currentIndex;
  bool get isUpdate => _isUpdate;

  void updateValues(int index, String title, String value, bool isUpdate) {
    _currentIndex = index;
    _titleValue = title;
    _inputValue = value;
    _isUpdate = isUpdate;
  }

  void addNote() {
    if (_isUpdate) {
      titleItems
        ..removeAt(currentIndex)
        ..insert(currentIndex, _titleValue);

      listItems
        ..removeAt(currentIndex)
        ..insert(currentIndex, _inputValue);
    } else {
      titleItems.add(_titleValue);
      listItems.add(_inputValue);
    }

    clear();

    notifyListeners();
  }

  void clear() {
    _titleValue = '';
    _inputValue = '';
    _currentIndex = 0;
    _isUpdate = false;
  }

  void deleteItem(int index) {
    listItems.removeAt(index);
    titleItems.removeAt(index);
    notifyListeners();
  }
}
