import 'dart:convert';

import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/cl_file.dart';
import 'package:chemin_du_local/core/widgets/cl_floating_button.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/features/commerces/business_hours.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/products/product.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/place_service.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_address_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_business_hours_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_description_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_header_image.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_paniers_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_products_list_big.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/page_schedules_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/widgets/schedule_field_controller.dart';
import 'package:chemin_du_local/features/storekeepers/storekeepers_graphql.dart';
import 'package:chemin_du_local/features/user/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:latlng/latlng.dart';
import 'package:sliver_tools/sliver_tools.dart';

class StoreKeeperPage extends StatefulWidget {
  const StoreKeeperPage({
    Key? key,
    this.storekeeperID,
    this.canEdit = false,
  }) : super(key: key);

  final String? storekeeperID;
  final bool canEdit;

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

  final ScheduleFieldController _mondayController = ScheduleFieldController();
  final ScheduleFieldController _tuesdayController = ScheduleFieldController();
  final ScheduleFieldController _wednesdayController = ScheduleFieldController();
  final ScheduleFieldController _thursdayController = ScheduleFieldController();
  final ScheduleFieldController _fridayController = ScheduleFieldController();
  final ScheduleFieldController _saturdayController = ScheduleFieldController();
  final ScheduleFieldController _sundayController = ScheduleFieldController();

  ClFile? _image;
  ClFile? _profilePicture;

  LatLng? _commerceLatLgn;

  bool _isEditing = false;
  bool _initialized = false;

  String _errorMessage = "";

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
      document: gql(commerceExists ? mutUpdateStorekeerCommercePage : ""),
      onError: (error) {
        _errorMessage = "Le commerce n'a pas pu être mise à jour...";
      },
      onCompleted: (dynamic data) {
        if (data == null) return;

        _errorMessage = "";
      }
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

    if (commerce != null && commerce.latitude != null && commerce.longitude != null) {
      _commerceLatLgn = LatLng(commerce.latitude!, commerce.longitude!);      
    }

    _mondayController.schedules = commerce?.businessHours?.monday ?? [];
    _tuesdayController.schedules = commerce?.businessHours?.tuesday?? [];
    _wednesdayController.schedules = commerce?.businessHours?.wednesday ?? [];
    _thursdayController.schedules = commerce?.businessHours?.thursday ?? [];
    _fridayController.schedules = commerce?.businessHours?.friday ?? [];
    _saturdayController.schedules = commerce?.businessHours?.saturday ?? [];
    _sundayController.schedules = commerce?.businessHours?.sunday ?? [];

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

        return _buildContent(
          products: products, 
          productsAvailableForClickAndCollect: commerce?.productsAvailableForClickAndCollect ?? [],
          commerce: commerce
        );
      }
    );
  }

  Widget _buildContent({
    required List<Product> products,
    required List<Product> productsAvailableForClickAndCollect,
    required Commerce? commerce,
  }) {
    return Mutation<dynamic>(
      options: _commerceMutationOption(commerce != null),
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
                      commerceID: commerce?.id,
                      imageData: _image,
                      profilePictureData: _profilePicture,
                      isEditing: _isEditing,
                      errorMessage: _errorMessage,
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
                            return _buildBigLayout(
                              commerce: commerce, 
                              products: products,
                              productsAvailableForClickAndCollect: productsAvailableForClickAndCollect,
                            );
                          }
            
                          return _buildSmallLayout(
                            commerce: commerce, 
                            products: products,
                            productsAvailableForClickAndCollect: productsAvailableForClickAndCollect
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          floatingActionButton: widget.canEdit ? ClFloatingButton(
            onPressed: () => _onEditSavePressed(commerce?.id, runMutation),
            icon: _isEditing ? Icons.save : Icons.edit,
          ) : null,
        );
      }
    );
  }

  Widget _buildSmallLayout({
    required Commerce? commerce,
    required List<Product> products,
    required List<Product> productsAvailableForClickAndCollect,
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
                  child: PageBusinessHoursCard(
                    mondayController: _mondayController,
                    tuesdayController: _tuesdayController,
                    wednesdayController: _wednesdayController,
                    thursdayController: _thursdayController,
                    fridayController: _fridayController,
                    saturdayController: _saturdayController,
                    sundayController: _sundayController,
                    isEditing: _isEditing
                  ),
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
                    initialLatLgn: _commerceLatLgn,
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
              child: PageProductsList(
                commerce: commerce,
                products: products, 
                availableForClickAndCollect: [
                  for (final product in productsAvailableForClickAndCollect)
                    product.id!
                ],
                enableButton: false,
              ),
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
                commerce: commerce,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18,)

      ],
    );
  }

  Widget _buildBigLayout({
    required Commerce? commerce,
    required List<Product> products,
    required List<Product> productsAvailableForClickAndCollect,
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
                        commerce: commerce,
                        products: products, 
                        availableForClickAndCollect: [
                          for (final product in productsAvailableForClickAndCollect)
                            product.id!
                        ],
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
                    Flexible(
                      child: PageBusinessHoursCard(
                        mondayController: _mondayController,
                        tuesdayController: _tuesdayController,
                        wednesdayController: _wednesdayController,
                        thursdayController: _thursdayController,
                        fridayController: _fridayController,
                        saturdayController: _saturdayController,
                        sundayController: _sundayController,
                        isEditing: _isEditing
                      ),
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
                        initialLatLgn: _commerceLatLgn,
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
                commerce: commerce,
              ),
            ),
          ),
        ),
        const SizedBox(height: 18,)
      ],
    );
  }

  Future _onEditSavePressed(String? commerceID, RunMutation? runMutation) async {
    if (_isEditing && !_formKey.currentState!.validate()) return;

    if (_isEditing && runMutation != null) {
      _commerceLatLgn = await PlaceAPIProvider.instance.latLgnForAddress(_addressTextController.text);

      if (_commerceLatLgn == null) {
        setState(() {
          _errorMessage = "Nous n'arrivons pas à récupérer les coordonnées du commerce. Verifiez l'adresse.";
        });
      }

      runMutation(<String, dynamic>{
        "id": commerceID,
        "storekeeperWord": _storekeeperWordTextController.text,
        "description": _descriptionTextController.text,
        "address": _addressTextController.text,
        "latitude": _commerceLatLgn!.latitude,
        "longitude": _commerceLatLgn!.longitude,
        "phone": _phoneTextController.text,
        "email": _emailTextController.text,
        "facebook": _facebookTextController.text,
        "twitter": _twitterTextController.text,
        "instagram": _instagramTextController.text,
        "businessHours": {
          "monday": _mondayController.schedules,
          "tuesday": _tuesdayController.schedules,
          "wednesday": _wednesdayController.schedules,
          "thursday": _thursdayController.schedules,
          "friday": _fridayController.schedules,
          "saturday": _saturdayController.schedules,
          "sunday": _sundayController.schedules,
        },
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