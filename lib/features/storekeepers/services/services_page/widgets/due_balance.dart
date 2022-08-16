import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/utils/dates_helper.dart';
import 'package:chemin_du_local/core/widgets/badge.dart';
import 'package:chemin_du_local/features/commerces/models/commerce/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/services/models/service_info/service_info.dart';
import 'package:chemin_du_local/features/storekeepers/services/services_graphql.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class DueBalance extends StatelessWidget {
  const DueBalance({Key? key, required this.commerce}) : super(key: key);

  final Commerce commerce;

  QueryOptions _serviceInfoQueryOption(String serviceID) {
    return QueryOptions(
      document: gql(qServiceInfo),
      variables: <String, dynamic>{
        "serviceID": serviceID
      }
    );
  } 

  @override
  Widget build(BuildContext context) {
    final bool isBilaledToday = DateTime.now().isSameDate(commerce.lastBilledDate!.add(const Duration(days: 30)));

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer
      ),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenHelper.instance.horizontalPadding,
        vertical: 20
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isBig = constraints.maxWidth >= ScreenHelper.breakpointTablet;

          final List<Widget> servicesBages = [
            for (final service in commerce.services)
              Query<dynamic>(
                options: _serviceInfoQueryOption(service.split("_").first),
                builder: (result, {fetchMore, refetch}) {
                  if (result.isLoading) {
                    return const Badge(child: CircularProgressIndicator());
                  }

                  if (result.hasException) {
                    return Badge(child: Text(service));
                  }

                  final ServiceInfo serviceInfo = ServiceInfo.fromJson(result.data!["serviceInfo"] as Map<String, dynamic>);

                  return Badge(
                    child: Text(serviceInfo.name)
                  );
                },
              ),
          ];

          final List<Widget> children = [
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Text(
                        "Vous êtes abonné à : ",
                        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      const SizedBox(width: 8,),
                      if (isBig) 
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: servicesBages,
                        )
                    ],
                  ),
                  if (!isBig) ...{
                    const SizedBox(height: 8,),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 32),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: servicesBages.length,
                        separatorBuilder: (context, index) => const SizedBox(width: 8,),
                        itemBuilder: (context, index) => servicesBages[index],
                      ),
                    ),
                    const SizedBox(height: 12,),
                  }
                ],
              )
            ),

            // Le prix
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${commerce.dueBalance != null ? commerce.dueBalance!.toStringAsFixed(2) : "Inconnue"}€",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary
                  ),
                ),
                const SizedBox(height: 4,),
                Flexible(
                  child: Text(
                    "Dû pour ${isBilaledToday ? "Aujourd'hui" : " le ${DateFormat("dd/MM/yyyy").format(commerce.lastBilledDate!.add(const Duration(days: 30)))}"}",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            )
          ];

          if (constraints.maxWidth >= ScreenHelper.breakpointTablet) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: children,
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children, 
          );
        },
      ),
    );
  }
}