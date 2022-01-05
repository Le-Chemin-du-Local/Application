import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/main_page/page_item.dart';
import 'package:chemin_du_local/features/dashboard/widgets/dashboard_card.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({
    Key? key,
    required this.onPageChanged,
  }) : super(key: key);

  final Function(PagesId) onPageChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ScreenHelper.horizontalPadding),
      child: CustomScrollView(
        slivers: [
          _buildMainView(),
          const SliverToBoxAdapter(child: SizedBox(height: 32,)),
          ..._buildServicesView(context)
        ],
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
          onClick: () => onPageChanged(PagesId.products), 
          backgroundName: "illustration_1.png", 
          title: "Lister mes produits"
        ),

        // Carte Gérer ma page
        DashboardCard(
          onClick: () {}, 
          backgroundName: "illustration_1.png", 
          title: "Gérer ma page"
        ),

        // Carte Gérer mes services
        DashboardCard(
          onClick: () {}, 
          backgroundName: "illustration_1.png", 
          title: "Gérer mes services"
        ),
      ]),
    );
  }

  List<Widget> _buildServicesView(BuildContext context) {
    return [
      SliverToBoxAdapter(
        child: Text("Mes services", style: Theme.of(context).textTheme.headline2,),
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
          DashboardCard(
            onClick: () => onPageChanged(PagesId.products), 
            backgroundName: "illustration_1.png", 
            title: "Click & collect"
          ),

          // Carte Voir plus de services
          DashboardCard(
            onClick: () {}, 
            backgroundName: "illustration_1.png", 
            title: "Voir plus de services"
          ),
        ]),
      ),
    ];
  }
}