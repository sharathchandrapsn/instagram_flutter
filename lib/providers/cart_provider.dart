import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final List<String> menuItems = [
    'Pizza',
    'Burger',
    'Pasta',
    'Fries',
    'Salad',
  ];

  List<String> items = [];

  int get itemCount => items.length;

  void addItem(String item) {
    items.add(item);
    notifyListeners();
  }

  void removeItem(String item) {
    items.remove(item);
    notifyListeners();
  }

  void clear() {
    items.clear();
    notifyListeners();
  }
}