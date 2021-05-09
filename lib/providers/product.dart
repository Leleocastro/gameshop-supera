import 'package:flutter/foundation.dart';

class Product with ChangeNotifier {
  final int id;
  final String name;
  final double price;
  final String image;
  final int score;

  Product({
    this.id,
    this.name,
    this.price,
    this.image,
    this.score,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      score: json['score'],
      image: json['image'],
    );
  }
}
