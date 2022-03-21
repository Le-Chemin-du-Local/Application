import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_address_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_description_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_header_image.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list_big.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_schedules_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class StoreKeeperPage extends StatefulWidget {
  const StoreKeeperPage({
    Key? key,
    this.storekeeperID,
  }) : super(key: key);

  final String? storekeeperID;

  @override
  State<StoreKeeperPage> createState() => _StoreKeeperPageState();
}

class _StoreKeeperPageState extends State<StoreKeeperPage> {
  final TextEditingController _descriptionTextController = TextEditingController();
  
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();

  final Map<String, String> _schedules = {};

  bool _loadedInitialData = false;
  bool _isEditing = false;

  QueryOptions _commerceQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetStoreKeeperCommerce),
      variables: <String, dynamic>{
        "id": widget.storekeeperID,
      },
      fetchPolicy: FetchPolicy.noCache
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Query<dynamic>(
        options: _commerceQueryOptions(),
        builder: (storekeeperResult, {fetchMore, refetch}) {
          if (storekeeperResult.isLoading) {
            return const Center(child: CircularProgressIndicator(),);
          }

          if (storekeeperResult.hasException) {
            return const Align(
              alignment: Alignment.topLeft,
              child: ClStatusMessage(
                message: "Nous ne parvenons pas à charger la page commerce...",
              ),
            );
          }

          final User storeKeeper = User.fromJson(storekeeperResult.data!["user"] as Map<String, dynamic>);
          final Commerce? commerce = storeKeeper.commerce;

          // The products
          final List mapProducts = storekeeperResult.data!["user"]["commerce"]["products"]["edges"] as List;
          final List<Product> products = [];

          for (final mapProduct in mapProducts) {
            products.add(Product.fromJson(mapProduct["node"] as Map<String, dynamic>));
          }

          // we need to put the values in the controllers
          _descriptionTextController.text = commerce?.description ?? "";
          _phoneTextController.text = commerce?.phone ?? "";
          _emailTextController.text = commerce?.email ?? "";
          _addressTextController.text = commerce?.address ?? "";

          // TODO: remove mock
          _schedules.addAll({
            "Monday": "Fermé",
            "Tuesday": "10h00 - 12h00 / 14h00 - 19h00",
            "Wednesday": "10h00 - 12h00",
            "Thursday": "10h00 - 12h00 / 14h00 - 19h00",
            "Friday": "10h00 - 12h00 / 14h00 - 19h00",
            "Saturday": "10h00 - 12h00 / 14h00 - 19h00",
            "Sunday": "Fermé"
          });

          return Stack(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: PageHeaderImage(commerceID: commerce?.id ?? ""),
              ),
              Positioned.fill(
                child: _buildContent(
                  products: products
                ),
              )
            ],
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditing = !_isEditing;
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: Palette.gradientPrimary
          ),
          child: Icon(
            _isEditing ? Icons.save : Icons.edit,
            color: Palette.colorWhite,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildContent({
    required List<Product> products,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > ScreenHelper.breakpointPC) {
          return _buildBigLayout(products: products);
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
          child: CustomScrollView(
            slivers: _buildSmallLayout(
              products: products
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildSmallLayout({
    required List<Product> products,
  }) {
    return [
      const SliverToBoxAdapter(child: SizedBox(height: 200,)),
      // The schedules card
      SliverToBoxAdapter(child: PageSchedulesCard(schedules: _schedules)),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The map card
      SliverToBoxAdapter(
        child: PageAddressCard(
          phoneTextController: _phoneTextController,
          emailTextController: _emailTextController,
          addressTextController: _addressTextController, 
          isEditing: _isEditing
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The description card
      SliverToBoxAdapter(
        child: PageDescriptionCard(
          descriptionTextController: _descriptionTextController,
          isEditing: _isEditing,
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The products list
      PageProductsList(
        products: products,
        useBigLayout: false,
        enableButton: false,
      )
    ];
  }

  Widget _buildBigLayout({
    required List<Product> products
  }) {
    return SingleChildScrollView(
      controller: ScrollController(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // The header space
          const SizedBox(height: 200,),

          // The main widgets
          Flexible(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // The first column
                Flexible(
                  flex: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Description
                        Flexible(
                          child: PageDescriptionCard(
                            descriptionTextController: _descriptionTextController, 
                            isEditing: _isEditing
                          ),
                        ),
                        const SizedBox(height: 17,),

                        // The products
                        Flexible(
                          child: PageProductsListBig(
                            products: products,
                            enableButton: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                // The second column
                Flexible(
                  flex: 40,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Schedules
                      Flexible(child: PageSchedulesCard(schedules: _schedules)),
                      const SizedBox(height: 10,),
                
                      // The map
                      Flexible(
                        child: PageAddressCard(
                          phoneTextController: _phoneTextController,
                          emailTextController: _emailTextController,
                          addressTextController: _addressTextController,
                          isEditing: _isEditing
                        ),
                      ),
                    ],
                  ),
                )
              ],   
            ),
          )
        ],
      )
    );
  }
}