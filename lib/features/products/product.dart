import 'package:flutter/foundation.dart';

@immutable
class Product {
  const Product({
    required this.name,
    required this.category,
    required this.description,
    required this.price,
  });

  final String name;
  final String category;
  final String description;

  final double price;

  Product copyWith({
    String? name,
    String? category,
    String? description,
    double? price,
  }) {
    return Product(
      name: name ?? this.name, 
      category: category ?? this.category,
      description: description ?? this.description,
      price: price ?? this.price,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
      other.name == name &&
      other.category == category &&
      other.description == description &&
      other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^
                      category.hashCode ^
                      description.hashCode ^
                      price.hashCode;

}