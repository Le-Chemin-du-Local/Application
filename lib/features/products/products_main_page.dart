import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/products/product_categories_page.dart';
import 'package:chemin_du_local/features/products/products_page.dart';
import 'package:flutter/material.dart';

class ProductsMainPage extends StatefulWidget {
  const ProductsMainPage({Key? key}) : super(key: key);

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  String _currentCategory = "";

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

         return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // The categories pannel
            Flexible(
              child: Container(
                constraints: BoxConstraints(maxWidth: isBigLayout ? 200 : double.infinity),
                decoration: const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Color(0xffdadada),
                      width: 1
                    )
                  )
                ),
                child: ProductCategoriesPage(
                  currentCategory: _currentCategory,
                  onCategorySelected: (category) {
                    if (isBigLayout) {
                      setState(() {
                        _currentCategory = category;
                      });
                    }
                    else {
                      setState(() {
                        _currentCategory = "";
                      });
            
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ProductsPage(category: category))
                      );
                    }
                  },
                ),
              ),
            ),

            // If we have enough space it's better to show the products
            // on the side rather than on a new page
            if (isBigLayout)
              if (_currentCategory.isNotEmpty) 
                Flexible(child: ProductsPage(category: _currentCategory, showAppBar: false,))
              else 
                const Center(child: Text("Veuillez selectionner une catégorie"),)
          ],
        );
      } 
    );
  }
}