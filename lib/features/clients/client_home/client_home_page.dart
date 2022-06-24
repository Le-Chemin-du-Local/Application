import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_address_input.dart';
import 'package:chemin_du_local/features/clients/client_home/widgets/commerces_list.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

class ClientHomePage extends StatefulWidget {
  const ClientHomePage({Key? key}) : super(key: key);

  @override
  State<ClientHomePage> createState() => _ClientHomePageState();
}

class _ClientHomePageState extends State<ClientHomePage> {
  final TextEditingController _addressTextController = TextEditingController();

  String? _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenHelper.instance.horizontalPadding,
            vertical: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // La barre d'adresse
              ClAddressInput(
                label: "",
                hint: "Où êtes vous en ce moment ?",
                addressTextController: _addressTextController,
                onSelected: _onAddressSelected,
              ),
              const SizedBox(height: 15,),

              // La liste des commerce
              Flexible(
                child: CommercesList(address: _address),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onAddressSelected(String address) {
    setState(() {
      _address = address;
    });
  }
}