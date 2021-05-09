import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:gameshop_supera/providers/cart.dart';

class Order {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    this.id,
    this.total,
    this.products,
    this.date,
  });
}

class Orders with ChangeNotifier {
  List<Order> _items = [];

  Orders([this._items = const []]);

  List<Order> get items {
    return [..._items];
  }

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadOrders() async {
    List<Order> loadedItems = [];

    // print(_url);
    Map<String, dynamic> data = json.decode('json vem aqui');
    loadedItems.clear();
    if (data != null) {
      data.forEach((orderId, orderData) {
        loadedItems.add(
          Order(
            id: orderId,
            total: orderData['total'].toDouble(),
            date: DateTime.parse(orderData['date']),
            products: (orderData['products'] as List<dynamic>).map((item) {
              return CartItem(
                id: item['id'],
                productId: item['productId'],
                name: item['name'],
                image: item['image'],
                quantity: item['quantity'],
                price: item['price'].toDouble(),
                frete: item['frete'].toDouble(),
              );
            }).toList(),
          ),
        );
      });
      notifyListeners();
    }

    _items = loadedItems.reversed.toList();
    return Future.value();
  }

  Future<void> addOrder(Cart cart) async {
    final date = DateTime.now();
    // final response = await http.post(
    //   'mudar isso aqui',
    //   body: json.encode({
    //     'total': cart.totalAmount,
    //     'date': date.toIso8601String(),
    //     'products': cart.items.values
    //         .map((cartItem) => {
    //               'id': cartItem.id,
    //               'productId': cartItem.productId,
    //               'title': cartItem.title,
    //               'imageUrl': cartItem.imageUrl,
    //               'quantity': cartItem.quantity,
    //               'price': cartItem.price,
    //             })
    //         .toList(),
    //   }),
    // );

    // _items.insert(
    //   0,
    //   Order(
    //     id: json.decode(response.body)['name'],
    //     total: cart.totalAmount,
    //     date: date,
    //     products: cart.items.values.toList(),
    //   ),
    // );

    notifyListeners();
  }
}
