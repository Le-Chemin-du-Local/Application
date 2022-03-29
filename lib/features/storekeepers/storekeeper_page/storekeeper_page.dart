import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_address_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_description_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_header_image.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_paniers_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list_big.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_schedules_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:sliver_tools/sliver_tools.dart';

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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _storekeeperWordTextController = TextEditingController();
  final TextEditingController _descriptionTextController = TextEditingController();
  
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();

  final TextEditingController _facebookTextController = TextEditingController();
  final TextEditingController _twitterTextController = TextEditingController();
  final TextEditingController _instagramTextController = TextEditingController();

  final Map<String, String> _schedules = {};

  ClFile? _image;
  ClFile? _profilePicture;

  bool _isEditing = false;
  bool _initialized = false;

  QueryOptions _commerceQueryOptions() {
    return QueryOptions<dynamic>(
      document: gql(qGetStoreKeeperCommercePage),
      variables: <String, dynamic>{
        "id": widget.storekeeperID,
      },
      fetchPolicy: FetchPolicy.noCache
    );
  }

  MutationOptions _commerceMutationOption(bool commerceExists) {
    return MutationOptions<dynamic>(
      document: gql(commerceExists ? mutUpdateStorekeerCommercePage : "")
    );
  }

  void _initialize(Commerce? commerce) {
    if (_initialized) return;

    // we need to put the values in the controllers
    _storekeeperWordTextController.text = commerce?.storekeeperWord ?? "Je suis un super commerce breton !";
    _descriptionTextController.text = commerce?.description ?? "";
    _phoneTextController.text = commerce?.phone ?? "";
    _emailTextController.text = commerce?.email ?? "";
    _addressTextController.text = commerce?.address ?? "";

    _facebookTextController.text = commerce?.facebook ?? "";
    _twitterTextController.text = commerce?.twitter ?? "";
    _instagramTextController.text = commerce?.instagram ?? "";

    _schedules.addAll({
      "Monday": "Fermé",
      "Tuesday": "10h00 - 12h00 / 14h00 - 19h00",
      "Wednesday": "10h00 - 12h00",
      "Thursday": "10h00 - 12h00 / 14h00 - 19h00",
      "Friday": "10h00 - 12h00 / 14h00 - 19h00",
      "Saturday": "10h00 - 12h00 / 14h00 - 19h00",
      "Sunday": "Fermé"
    });

    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    return Query<dynamic>(
      options: _commerceQueryOptions(),
      builder: (storekeeperResult, {fetchMore, refetch}) {
        if (storekeeperResult.isLoading) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator(),)
          );
        }

        if (storekeeperResult.hasException) {
          return Scaffold(
            appBar: AppBar(),
            body: const Align(
              alignment: Alignment.topLeft,
              child: ClStatusMessage(
                message: "Nous ne parvenons pas à charger la page commerce...",
              ),
            )
          );
        }

        final User storeKeeper = User.fromJson(storekeeperResult.data!["user"] as Map<String, dynamic>);
        final Commerce? commerce = storeKeeper.commerce;

        _initialize(commerce);

        // The products
        final List mapProducts = storekeeperResult.data!["user"]["commerce"]["products"]["edges"] as List;
        final List<Product> products = [];

        for (final mapProduct in mapProducts) {
          products.add(Product.fromJson(mapProduct["node"] as Map<String, dynamic>));
        }

        return _buildContent(products: products, commerceID: commerce?.id);
      }
    );
  }

  Widget _buildContent({
    required List<Product> products,
    required String? commerceID,
  }) {
    return Mutation<dynamic>(
      options: _commerceMutationOption(commerceID != null),
      builder: (runMutation, mutationResult) {
        if (mutationResult?.isLoading ?? false) {
          return Scaffold(
            appBar: AppBar(),
            body: const Center(child: CircularProgressIndicator(),)
          );
        }

        return Scaffold(
          body: Form(
            key: _formKey,
            child: CustomScrollView(
              controller: ScrollController(),
              slivers: [
                SliverStack(
                  children: [
                    PageHeaderImage(
                      storekeeperWordTextController: _storekeeperWordTextController,
                      commerceID: commerceID,
                      imageData: _image,
                      profilePictureData: _profilePicture,
                      isEditing: _isEditing,
                      onImageSelected: (image) {
                        setState(() {
                          _image = image;
                        });
                      },
                      onProfilePictureSelected: (image) {
                        setState(() {
                          _profilePicture = image;
                        });
                      },
                    ),
                    SliverToBoxAdapter(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth >= ScreenHelper.breakpointPC) {
                            return _buildBigLayout(commerceID: commerceID, products: products);
                          }
            
                          return _buildSmallLayout(commerceID: commerceID, products: products);
                        },
                      ),
                    ),
                    if (mutationResult?.hasException ?? false)
                      SliverPositioned(
                        top: 16,
                        left: 16,
                        right: 16,
                        child: ClStatusMessage(
                          message: "Nous ne parvenons pas à mettre à jour la page... ${mutationResult?.exception}",
                        ),
                    )
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: ClFloatingButton(
            onPressed: () => _onEditSavePressed(commerceID, runMutation),
            icon: _isEditing ? Icons.save : Icons.edit,
          ),
        );
      }
    );
  }

  Widget _buildSmallLayout({
    required String? commerceID,
    required List<Product> products,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 316,),

        // Première section
        Flexible(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Les horaires
                Flexible(
                  child: PageSchedulesCard(schedules: _schedules),
                ),
                const SizedBox(height: 10,),

                // Les coordonnées
                Flexible(
                  child: PageAddressCard(
                    addressTextController: _addressTextController,
                    emailTextController: _emailTextController,
                    phoneTextController: _phoneTextController,
                    facebookTextController: _facebookTextController,
                    twitterTextController: _twitterTextController,
                    instagramTextController: _instagramTextController,
                    isEditing: _isEditing,
                  ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ),

        Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: ScreenHelper.horizontalPadding),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 300),
              child: PageProductsList(products: products, enableButton: false,),
            ),
          ),
        ),
        const SizedBox(height: 10,),

        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Padding(
              padding: const EdgeInsets.only(
                left: ScreenHelper.horizontalPadding
              ),
              child: PagePaniersList(
                commerceID: commerceID,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18,)

      ],
    );
  }

  Widget _buildBigLayout({
    required String? commerceID,
    required List<Product> products
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 316,),
        Padding(
           padding: const EdgeInsets.symmetric(
            horizontal: ScreenHelper.horizontalPadding
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Première colonne
              Flexible(
                flex: 55,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Description du commerce
                    PageDescriptionCard(
                      descriptionTextController: _descriptionTextController, 
                      isEditing: _isEditing
                    ),
                    const SizedBox(height: 10,),
                    
                    // Les produits
                    Flexible(
                      child: PageProductsListBig(
                        enableButton: false,
                        products: products,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 12,),
        
              // Seconde colonne
              Flexible(
                flex: 45,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children:[
                    // Les horraires
                    const Flexible(
                      child: PageSchedulesCard(schedules: {}),
                    ),
                    const SizedBox(height: 10,),
        
                    // Le coordonnes
                    Flexible(
                      child: PageAddressCard(
                        addressTextController: _addressTextController,
                        emailTextController: _emailTextController,
                        phoneTextController: _phoneTextController,
                        facebookTextController: _facebookTextController,
                        twitterTextController: _twitterTextController,
                        instagramTextController: _instagramTextController,
                        isEditing: _isEditing,
                      ),
                    ),
                    const SizedBox(height: 10,),
        
                    //
                  ],
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 18,),

        // Liste des paniers
        Flexible(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 450),
            child: Padding(
              padding: const EdgeInsets.only(
                left: ScreenHelper.horizontalPadding
              ),
              child: PagePaniersList(
                commerceID: commerceID,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18,)
      ],
    );
  }

  void _onEditSavePressed(String? commerceID, RunMutation? runMutation) {
    if (_isEditing && !_formKey.currentState!.validate()) return;

    if (_isEditing && runMutation != null) {
      runMutation(<String, dynamic>{
        "id": commerceID,
        "storekeeperWord": _storekeeperWordTextController.text,
        "description": _descriptionTextController.text,
        "address": _addressTextController.text,
        "phone": _phoneTextController.text,
        "email": _emailTextController.text,
        "facebook": _facebookTextController.text,
        "twitter": _twitterTextController.text,
        "instagram": _instagramTextController.text,
        if (_image != null) 
          "image": MultipartFile.fromBytes(
            "image",
            base64Decode(_image!.base64content!),
            filename: _image!.filename
          ),
        if (_profilePicture != null) 
          "profilePicture": MultipartFile.fromBytes(
            "profilePicture",
            base64Decode(_profilePicture!.base64content!),
            filename: _profilePicture!.filename
          ),
      });
    }

    setState(() {
      _isEditing = !_isEditing;
    });
  }
}