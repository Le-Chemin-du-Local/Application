import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/features/commerce/commerce_controller.dart';
import 'package:chemin_du_local/features/commerce/widgets/mypage_address_card.dart';
import 'package:chemin_du_local/features/commerce/widgets/mypage_description_card.dart';
import 'package:chemin_du_local/features/commerce/widgets/mypage_header_image.dart';
import 'package:chemin_du_local/features/commerce/widgets/mypage_products_list.dart';
import 'package:chemin_du_local/features/commerce/widgets/mypage_schedules_card.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyPagePage extends ConsumerStatefulWidget {
  const MyPagePage({Key? key}) : super(key: key);

  @override
  ConsumerState<MyPagePage> createState() => _MyPagePageState();
}

class _MyPagePageState extends ConsumerState<MyPagePage> {
  final TextEditingController _descriptionTextController = TextEditingController();
  
  final TextEditingController _phoneTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _addressTextController = TextEditingController();

  final Map<String, String> _schedules = {};

  bool _loadedInitialData = false;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();

    ref.read(commerceControllerProvider.notifier).loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Builder(
        builder: (context) {
          return ref.watch(commerceControllerProvider).commerce.when(
            data: (commerce) {
              // In the case the commerce is loaded for the first time
              // we need to put the values in the controllers
              if (!_loadedInitialData) {
                _descriptionTextController.text = commerce?.description ?? "";
                _phoneTextController.text = commerce?.phoneNumber ?? "";
                _emailTextController.text = commerce?.emailAddress ?? "";
                _addressTextController.text = commerce?.address ?? "";

                _schedules.addAll(commerce?.schedules ?? {});

                _loadedInitialData = true;
              }

              return Stack(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: MyPageHeaderImage(imageSrc: "assets/images/header.png"),
                  ),
                  Positioned.fill(
                    child: _buildContent(),
                  )
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator(),),
            error: (error, stackTrace) => const Center(child: Text("Impossible de charger votre commerce..."),),
          );
        },
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

  Widget _buildContent() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
          child: CustomScrollView(
            slivers: _buildSmallLayout(),
          ),
        );
      },
    );
  }

  List<Widget> _buildSmallLayout() {
    return [
      const SliverToBoxAdapter(child: SizedBox(height: 200,)),
      // The schedules card
      SliverToBoxAdapter(child: MyPageSchedulesCard(schedules: _schedules)),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The map card
      SliverToBoxAdapter(
        child: MyPageAddressCard(
          phoneTextController: _phoneTextController,
          emailTextController: _emailTextController,
          addressTextController: _addressTextController, 
          isEditing: _isEditing
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The description card
      SliverToBoxAdapter(
        child: MyPageDescriptionCard(
          descriptionTextController: _descriptionTextController,
          isEditing: _isEditing,
        ),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 18,)),

      // The products list
      const MyPageProductsList(
        useBigLayout: false,
        enableButton: false,
      )
    ];
  }


}