import 'package:chemin_du_local/core/helpers/app_manager.dart';
import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_appbar.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/ccproducts_page/ccproducts_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/paniers_page/paniers_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/services.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_home/widgets/dashboard_card.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_home/widgets/dashboard_services_card.dart';
import 'package:flutter/material.dart';

class StoreKeeperHomePage extends StatelessWidget {
  const StoreKeeperHomePage({
    Key? key,
    required this.onPageChanged,
    required this.onShowDrawer,
    required this.commerceID,
    this.servicesOffset = 0,
    this.services = const [],
  }) : super(key: key);

  final Function(int) onPageChanged;
  final Function() onShowDrawer;
  final int servicesOffset;

  final List<String> services;

  final String commerceID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ClAppBar(
        canPop: false,
        onShowDrawer: onShowDrawer,
        title: const Text("Bienvenue, Guillaume 👋"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenHelper.instance.horizontalPadding,
        ),
        child: CustomScrollView(
          controller: ScrollController(),
          slivers: [
            _buildMainView(),
            const SliverToBoxAdapter(child: SizedBox(height: 32,)),
            ..._buildServicesView(context)
          ],
        ),
      ),
    );
  }

  Widget _buildMainView() {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisExtent: 228,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16
      ),
      delegate: SliverChildListDelegate([
        // Carte des produits
        DashboardCard(
          onClick: () => onPageChanged(2), 
          backgroundName: "illustration_2.png", 
          title: "Lister mes produits"
        ),

        // Carte Gérer ma page
        DashboardCard(
          onClick: () => onPageChanged(0), 
          backgroundName: "illustration_3.png", 
          title: "Gérer ma page"
        ),

        // Carte Gérer mes services
        DashboardCard(
          onClick: () => onPageChanged(3 + servicesOffset),
          backgroundName: "illustration_4.png", 
          title: "Gérer mes services"
        ),
      ]),
    );
  }

  List<Widget> _buildServicesView(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Text("Mes services", style: Theme.of(context).textTheme.headlineMedium,),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 16,)),
      SliverGrid(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          mainAxisExtent: 228,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16
        ),
        delegate: SliverChildListDelegate([
          // Carte Click & Collect
          if (services.contains(Services.clickAndCollect))
            DashboardCard(
              onClick: () async { 
                onPageChanged(3 + servicesOffset);
                await Future<dynamic>.delayed(const Duration(milliseconds: 200));
                Navigator.of(AppManager.instance.serviesPageKey.currentContext ?? context).push<dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => CCProductsPage(commerceID: commerceID,)
                  )
                );
              },
              backgroundName: "illustration_click_and_collect.png", 
              title: "Click & collect"
            ),

          // Carte paniers
          if (services.contains(Services.paniers))
            DashboardCard(
              onClick: () async {
                onPageChanged(3 + servicesOffset);
                await Future<dynamic>.delayed(const Duration(milliseconds: 200));
                Navigator.of(AppManager.instance.serviesPageKey.currentContext ?? context).push<dynamic>(
                  MaterialPageRoute<dynamic>(
                    builder: (context) => const PaniersPage()
                  )
                );
              }, 
              backgroundName: "illustration_click_and_collect.png", 
              title: "Paniers"
            ),

          // Carte Voir plus de services
          DashboardServicesCard(
            onClick: () => onPageChanged(3 + servicesOffset),
          ),
        ]),
      ),
      const SliverToBoxAdapter(child: SizedBox(height: 24,)),
    ];
  }
}