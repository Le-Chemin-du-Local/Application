import 'package:chemin_du_local/core/widgets/cl_card.dart';
import 'package:chemin_du_local/core/widgets/cl_elevated_button.dart';
import 'package:chemin_du_local/features/commands/panier_page/panier_command_page.dart';
import 'package:chemin_du_local/features/storekeepers/services/paniers/panier_command.dart';
import 'package:chemin_du_local/presentation/c_l_icons_icons.dart';
import 'package:chemin_du_local/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';

class PanierCommandCard extends StatelessWidget {
  const PanierCommandCard({
    Key? key,
    required this.command,
    required this.index,
    required this.runMutation,
    this.onMarkAsDone,
  }) : super(key: key);

  final PanierCommand command;
  final int index;

  final Function()? onMarkAsDone;
  final RunMutation? runMutation;

  @override
  Widget build(BuildContext context) {
    return ClCard(
      padding: const EdgeInsets.only(
        top: 24,
        left: 0,
        right: 0,
        bottom: 0
      ),
      backgroundColor: command.status == PanierCommandStatus.ready 
        ? Palette.colorCommandReady
        : Theme.of(context).cardColor
      ,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).push<dynamic>(
            MaterialPageRoute<dynamic>(
              builder: (context) => PanierCommandPage(
                panierCommandID: command.id!,
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
            ),
            const SizedBox(height: 12,),

            // Le footer
            Flexible(
              child: _buildFooter(context),
            )

          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
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
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Wrap(
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
            "${command.panier.price}€"
          ),

          // The arrow button
          const Icon(Icons.arrow_forward)
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Le tag
        Flexible(
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                topRight: Radius.circular(12)
              )
        
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(CLIcons.clickandcollect, size: 24, color: Palette.colorWhite,),
                SizedBox(width: 4,),
        
                Text("Panier", style: TextStyle(color: Palette.colorWhite),)
              ],
            ),
          ),
        ),

        // Le bouton
        if (onMarkAsDone != null)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClElevatedButton(
                onPressed: onMarkAsDone,
                child: const Text("Distribué"),
              ),
            ),
          )
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
}