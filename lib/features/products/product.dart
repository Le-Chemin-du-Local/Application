import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:flutter/cupertino.dart';

const Map<String, IconData> categoryIcon = {
  "Bières & cidres": CLIcons.bierescidres,
  "Fruits": CLIcons.fruits
};

@immutable
class Product {
  const Product({
    required this.name,
    required this.categories,
    required this.description,
    required this.price,
    required this.isBreton,
  });

  final String name;
  final String description;

  final List<String> categories;

  final double price;
  final bool isBreton;

  Product copyWith({
    String? name,
    String? description,
    List<String>? categories,
    double? price,
    bool? isBreton,
  }) {
    return Product(
      name: name ?? this.name, 
      categories: categories ?? this.categories,
      description: description ?? this.description,
      price: price ?? this.price,
      isBreton: isBreton ?? this.isBreton,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
      other.name == name &&
      other.categories == categories &&
      other.description == description &&
      other.price == price &&
      other.isBreton == isBreton;
  }

  @override
  int get hashCode => name.hashCode ^
                      categories.hashCode ^
                      description.hashCode ^
                      price.hashCode ^
                      isBreton.hashCode;

}