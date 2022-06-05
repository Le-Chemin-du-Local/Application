import 'package:chemin_du_local/core/helpers/screen_helper.dart';
import 'package:chemin_du_local/core/widgets/cl_status_message.dart';
import 'package:chemin_du_local/core/widgets/inputs/cl_address_input.dart';
import 'package:chemin_du_local/features/commerces/commerces_list_page.dart/widgets/commerces_list.dart';
import 'package:chemin_du_local/place/place_service.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';

class CommercesListPage extends StatefulWidget {
  const CommercesListPage({Key? key}) : super(key: key);

  @override
  State<CommercesListPage> createState() => _CommercesListPageState();
}

class _CommercesListPageState extends State<CommercesListPage> {
  final TextEditingController _addressTextController = TextEditingController();

  String? _address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch, 
        children: [
          // La bar de recherche
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: ScreenHelper.horizontalPadding),
            child: ClAddressInput(
              addressTextController: _addressTextController,
              onSelected: _onAddressSelected,
            ),
          ),
          const SizedBox(height: 12,),

          // La liste des commerces
          FutureBuilder(
            future: _getCoordinates(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator(),);
              }

              if (!snapshot.hasData) {
                return const Align(
                  alignment: Alignment.topCenter,
                  child: ClStatusMessage(
                    type: ClStatusMessageType.info,
                    message: "Vous devez rentrer une adresse ou votre localisation pour voir les commerces les plus proches",
                  ),
                );
              }

              return Expanded(
                child: CommercesList(
                  userCoordinated: snapshot.data as LatLng,
                ),
              );
            },
          )
        ],
      ),
    );
  }

  void _onAddressSelected(String address) {
    setState(() {
      _address = address;
    });
  }

  Future<LatLng?> _getCoordinates() async {
    if (_address != null) {
      return PlaceAPIProvider.instance.latLgnForAddress(_address!);
    }

    final locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!locationServiceEnabled) return null;

    // On a besoin de demander l'autorisation sur beaucoup d'appareil
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    final position = await Geolocator.getCurrentPosition();
    return LatLng(position.latitude, position.longitude);
  }
}