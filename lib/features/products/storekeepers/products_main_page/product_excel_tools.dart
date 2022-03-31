import 'dart:typed_data';

import 'package:chemin_du_local/features/products/product.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ProductExcelTools {
  ProductExcelTools._();

  static final ProductExcelTools instance = ProductExcelTools._();

  List<Product> readProductsFromExcel(Uint8List excelBytes) {
    final Excel excel = Excel.decodeBytes(excelBytes);
    final List<Product> result = [];

    if (excel.tables.isEmpty) throw Exception("la table est vide");

    final Sheet table = excel.tables.values.first;

    for (int i = 3; i < table.rows.length; ++i) {
      final List<Data?> line = table.row(i);
      
      // On soit parse les catégories
      List<String> categories = [];

      for (final categoryStringIndex in (line[6]!.value as String).trim().split(",")) {
        int categoryIndex = int.parse(categoryStringIndex.replaceAll("#", ""));
        categories.add(kCategories[categoryIndex - 1]);
      }

      final Product prodcut = Product(null, 
        name: line[0]!.value as String,
        description: line[1]!.value as String,
        price: line[2]!.value as double,
        unit: line[3]!.value as String,
        tva: double.parse(line[4]!.value.toString()),
        isBreton: (line[5]!.value as String).trim().toLowerCase() == "vrai",
        categories: categories,
      );

      result.add(prodcut);
    }

    return result;
  }
}