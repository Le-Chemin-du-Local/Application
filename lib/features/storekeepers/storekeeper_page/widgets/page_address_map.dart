import 'package:chemin_du_local/features/storekeepers/storekeeper_page/place_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class PageAddressMap extends StatefulWidget {
  const PageAddressMap({
    Key? key,
    required this.address
  }) : super(key: key);

  final String address;

  @override
  State<PageAddressMap> createState() => _PageAddressMapState();
}

class _PageAddressMapState extends State<PageAddressMap> {
  final MapController _controller = MapController(
    location: LatLng(47.6785, -3.2130),
    zoom: 16
  );

  LatLng? _addressLocation;

  Offset? _dragStart;
  double _scaleStart = 1.0;

  void _initialize() {
    PlaceAPIProvider.instance.latLgnForAddress(widget.address).then((value) {
      _addressLocation = value;

      if (value != null) {
        _controller.center = value;
      }

      setState(() {});
    });
  }
  
  @override
  void initState() {
    super.initState();

    _initialize();
  }

  @override
  void didUpdateWidget(covariant PageAddressMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    _initialize();
  }

  void _onDoubleTap() {
    _controller.zoom += 0.5;
    setState(() {});
  }

  void _onScaleStart(ScaleStartDetails details) {
    _dragStart = details.focalPoint;
    _scaleStart = 1.0;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final scaleDiff = details.scale - _scaleStart;
    _scaleStart = details.scale;

    if (scaleDiff > 0) {
      _controller.zoom += 0.02;
      setState(() {});
    } else if (scaleDiff < 0) {
      _controller.zoom -= 0.02;
      setState(() {});
    } else {
      final now = details.focalPoint;
      final diff = now - _dragStart!;
      _dragStart = now;
      _controller.drag(diff.dx, diff.dy);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 280),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onDoubleTap: _onDoubleTap,
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          child: Listener(
            behavior: HitTestBehavior.opaque,
            onPointerSignal: (event) {
              if (event is PointerScrollEvent) {
                final delta = event.scrollDelta;
    
                _controller.zoom -= delta.dy / 1000.0;
                setState(() {});
              }
            },
            child: MapLayoutBuilder(
              controller: _controller,
              builder: (context, transformer) {
                final Offset? markerPosition = _addressLocation == null ? null : transformer.fromLatLngToXYCoords(_addressLocation!);

                return Stack(
                  children: [
                    Map(
                      controller: _controller,
                      builder: (context, x, y, z) {
                        //Legal notice: This url is only used for demo and educational purposes. You need a license key for production use.
                        //Google Maps
                        final url = 'https://www.google.com/maps/vt/pb=!1m4!1m3!1i$z!2i$x!3i$y!2m3!1e0!2sm!3i420120488!3m7!2sen!5e1105!12m4!1e68!2m2!1sset!2sRoadmap!4e0!5m1!1e0!23i4111425';
              
                        return Image.network(
                          url,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                    if (markerPosition != null)
                      _buildMarkerWidget(markerPosition, Theme.of(context).primaryColor)
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMarkerWidget(Offset pos, Color color, [IconData icon = Icons.location_on]) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: Icon(
        icon,
        color: color,
        size: 48,
      ),
    );
  }
}