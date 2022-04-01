import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/commerces/commerce.dart';
import 'package:chemin_du_local/features/storekeepers/storekeeper_page/storekeeper_page.dart';
import 'package:flutter/material.dart';

class CommerceCard extends StatelessWidget {
  const CommerceCard({
    Key? key,
    required this.commerce
  }) : super(key: key);

  final Commerce commerce;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _openCommercePage(context),
      child: ClCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(commerce.name)
          ],
        ),
      ),
    );
  }

  Future _openCommercePage(BuildContext context) async {
    await Navigator.of(context).push<dynamic>(
      MaterialPageRoute<dynamic>(
        builder: (context) => StoreKeeperPage(storekeeperID: commerce.storekeeper?.id,)
      )
    );
  }
}