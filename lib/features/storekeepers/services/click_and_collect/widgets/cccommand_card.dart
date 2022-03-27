import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand.dart';
import 'package:chemin_du_local/features/storekeepers/services/click_and_collect/cccommand_page/cccommand_page.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class CCCommandCard extends StatelessWidget {
  const CCCommandCard({
    Key? key,
    required this.command,
    required this.index,
    required this.runMutation,
  }) : super(key: key);

  final CCCommand command;
  final int index;

  final RunMutation? runMutation;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
        bottom: 40
      ),
      backgroundColor: command.status == CCCommandStatus.ready 
        ? Palette.colorCommandReady
        : Theme.of(context).cardColor
      ,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push<dynamic>(
            MaterialPageRoute<dynamic>(
              builder: (context) => CCCommandPage(
                cccommandID: command.id!,
                runMutation: runMutation,
              )
            )
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Build the header
            Flexible(
              child: _buildHeader(),
            ),
            const SizedBox(height: 12,),
      
            // The content
            Flexible(
              child: _buildContent(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        // The user full name
        Expanded(
          child: Text(
            "${command.user?.firstName ?? ""} ${command.user?.lastName ?? ""}",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        // The command index
        Text("#$index")
      ],
    );
  }

  Widget _buildContent() {
    return Wrap(
      spacing: 30,
      runSpacing: 16,
      children: [
        // The date
        _buildSmallInfo(
          Icons.calendar_today, 
          DateFormat("dd/MM/yyyy").format(command.pickupDate)
        ),

        // The time
        _buildSmallInfo(
          Icons.access_time,
          DateFormat.Hm().format(command.pickupDate)
        ),

        // The price
        _buildSmallInfo(
          Icons.account_balance_wallet,
          "${_calculatePrice()}€"
        ),

        // The arrow button
        const Icon(Icons.arrow_forward)
      ],
    );
  }

  Widget _buildSmallInfo(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon),
        const SizedBox(width: 4,),

        Text(text)
      ],
    );
  }

  double _calculatePrice() {
    double price = 0.0;

    for (final ccproduct in command.products) {
      price += ccproduct.product.price ?? 0;
    }

    return price;
  }
}