import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gameshop_supera/providers/product.dart';

class Products with ChangeNotifier {
  Products([this._items = const []]);

  List<Product> _items = [];

  List<Product> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<String> _carregaProdutoJson() async {
    return await rootBundle.loadString('assets/data/products.json');
  }

  Future<void> loadProducts() async {
    // print(_url);
    String jsonString = await _carregaProdutoJson();
    final data = json.decode(jsonString);

    if (data != null) {
      _items = data.map<Product>((json) => Product.fromJson(json)).toList();

      notifyListeners();
    }
    return Future.value();
  }

  bool alphabeticOrderBy(bool isAscending) {
    if (isAscending) {
      _items.sort((a, b) {
        var aName = a.name;
        var bName = b.name;
        return aName.compareTo(bName);
      });
      notifyListeners();
      return false;
    } else {
      _items.sort((a, b) {
        var aName = a.name;
        var bName = b.name;
        return -aName.compareTo(bName);
      });
      notifyListeners();
      return true;
    }
  }

  bool priceOrderBy(bool isAscending) {
    if (isAscending) {
      _items.sort((a, b) {
        var aPrice = a.price;
        var bPrice = b.price;
        return aPrice.compareTo(bPrice);
      });
      notifyListeners();
      return false;
    } else {
      _items.sort((a, b) {
        var aPrice = a.price;
        var bPrice = b.price;
        return -aPrice.compareTo(bPrice);
      });
      notifyListeners();
      return true;
    }
  }

  bool scoreOrderBy(bool isAscending) {
    if (isAscending) {
      _items.sort((a, b) {
        var aScore = a.score;
        var bScore = b.score;
        return aScore.compareTo(bScore);
      });
      notifyListeners();
      return false;
    } else {
      _items.sort((a, b) {
        var aScore = a.score;
        var bScore = b.score;
        return -aScore.compareTo(bScore);
      });
      notifyListeners();
      return true;
    }
  }
}
