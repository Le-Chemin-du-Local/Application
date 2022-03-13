import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/product_categories_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/product_edit_page.dart';
import 'package:chemin_du_local/features/products/storekeepers/products_main_page/products_page.dart';
import 'package:flutter/material.dart';

class ProductsMainPage extends StatefulWidget {
  const ProductsMainPage({Key? key}) : super(key: key);

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  String _currentCategory = "";

  GlobalKey<ProductCategoriesPageState> _categoriesPageKey = GlobalKey<ProductCategoriesPageState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isBigLayout = constraints.maxWidth >= ScreenHelper.breakpointPC;

         return SizedBox(
           width: constraints.maxWidth,
           child: Row(
            // mainAxisSize: MainAxisSize.min,
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
                    key: _categoriesPageKey,
                    currentCategory: _currentCategory,
                    onCategorySelected: (category) => _onCategorySelected(category, isBigLayout: isBigLayout),
                    showAddButton: !isBigLayout,
                  ),
                ),
              ),
         
              // If we have enough space it's better to show the products
              // on the side rather than on a new page
              if (isBigLayout)
                if (_currentCategory.isNotEmpty) 
                  Flexible(
                    child: ProductsPage(
                      category: _currentCategory, 
                      showAppBar: false,
                      onProductAdded: _onProductAdded
                    )
                  )
                else 
                  Flexible(
                    child: Scaffold(
                      body: const Center(
                        child: Text("Veuillez selectionner une catégorie"),
                      ),
                      floatingActionButton: ClFloatingButton(
                        onPressed: _openProductCreationPage,
                        icon: Icons.add,
                      ),
                    )
                  )
            ],
                 ),
         );
      } 
    );
  }

  Future _onCategorySelected(String category, {
    required bool isBigLayout
  }) async {
    if (isBigLayout) {
      setState(() {
        _currentCategory = category;
      });
    }
    else {
      setState(() {
        _currentCategory = "";
      });

      await Navigator.of(context).push<dynamic>(
        MaterialPageRoute<dynamic>(
          builder: (context) => ProductsPage(
            category: category,
            onProductAdded: () => _categoriesPageKey.currentState!.refetchData(),
          )
        )
      );
    }
  }

  void _onProductAdded() {
    setState(() {
      _currentCategory = "";
    });
    _categoriesPageKey.currentState!.refetchData();
  }

  Future _openProductCreationPage() async {
    bool hasProductUpdate = await Navigator.of(context).push<bool?>(
      MaterialPageRoute<bool?>(
        builder: (context) => const ProductPage(productID: null)
      )
    ) ?? false;

    if (hasProductUpdate) _categoriesPageKey.currentState!.refetchData();
  }
}