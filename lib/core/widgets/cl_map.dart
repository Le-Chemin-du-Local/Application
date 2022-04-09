import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:latlng/latlng.dart';
import 'package:map/map.dart';

class ClMap extends StatefulWidget {
  const ClMap({
    Key? key,
    this.initialLatLgn,
    this.showInitialLatLgnMarker = false,
    this.markers = const [],
    this.initialZoom = 16,
  }) : super(key: key);

  final LatLng? initialLatLgn;
  final bool showInitialLatLgnMarker;

  final List<LatLng> markers;

  final double initialZoom;

  @override
  State<ClMap> createState() => _ClMapState();
}

class _ClMapState extends State<ClMap> {
  late MapController _controller;

  Offset? _dragStart;
  double _scaleStart = 1.0;

  @override
  void initState() {
    _controller = MapController(
      location: widget.initialLatLgn ?? LatLng(47.6785, -3.2130),
      zoom: widget.initialZoom
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant ClMap oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialLatLgn != null) {
      _controller.center = widget.initialLatLgn!;
    }
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
    return ConstrainedBox(
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
              final Offset? initilalMarkerPosition = !widget.showInitialLatLgnMarker || widget.initialLatLgn == null ? null : transformer.fromLatLngToXYCoords(widget.initialLatLgn!);

              final List<Offset> markersPositions = [];

              for (final marker in widget.markers) {
                markersPositions.add(transformer.fromLatLngToXYCoords(marker));
              }

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
                  // On affiche le centre si besoin
                  if (initilalMarkerPosition != null)
                    _buildMarkerWidget(initilalMarkerPosition),

                  // Les autres markers
                  for (final offset in markersPositions) 
                    _buildMarkerWidget(offset),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildMarkerWidget(Offset pos) {
    return Positioned(
      left: pos.dx - 24,
      top: pos.dy - 24,
      width: 48,
      height: 48,
      child: Image.asset(
        "assets/images/map_pointer.png",
        width: 48, height: 48,
      ),
    );
  }
}