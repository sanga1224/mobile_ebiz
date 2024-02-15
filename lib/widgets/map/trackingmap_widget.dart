import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as map;
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:latlong2/latlong.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mobile_ebiz/models/bldetail/bl_trackingmap.dart';
import 'package:mobile_ebiz/models/map/location.dart';
import 'package:mobile_ebiz/models/map/path.dart';
import 'package:mobile_ebiz/services/api_map.dart';
import 'dart:math' as math;

class TrackingMapWidget extends StatelessWidget {
  const TrackingMapWidget({super.key, required this.blno});
  final String blno;

  @override
  Widget build(BuildContext context) {
    Future<BLTrackingMap> mapData = ApiMap.getTrackingMapData(blno);

    map.LatLngBounds getBounds(List<MapLocation> lst) {
      List<LatLng> locList = [];
      for (MapLocation loc in lst) {
        locList.add(LatLng(loc.lat, loc.lng));
      }
      return map.LatLngBounds.fromPoints(locList);
    }

    List<map.Marker> getMarkers(List<MapLocation> lst) {
      List<map.Marker> result = [];
      for (MapLocation loc in lst) {
        if (loc.seq == 0) {
          result.add(
            map.Marker(
              point: LatLng(loc.lat, loc.lng),
              width: 30,
              height: 30,
              child: JustTheTooltip(
                isModal: true,
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(loc.name),
                ),
                child: Transform.rotate(
                  angle: loc.course * math.pi / 180,
                  child: const Icon(
                    Icons.arrow_circle_up,
                    color: Colors.deepPurple,
                    size: 25,
                  ),
                ),
              ),
            ),
          );
        } else {
          result.add(
            map.Marker(
              point: LatLng(loc.lat, loc.lng),
              width: 30,
              height: 30,
              child: JustTheTooltip(
                isModal: true,
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(loc.name),
                ),
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ),
          );
        }
      }
      return result;
    }

    map.Polyline getPaths(List<MapPath> lst) {
      List<LatLng> polylineCoordicates = [];

      for (MapPath path in lst) {
        polylineCoordicates.add(LatLng(path.lat, path.lng));
      }

      return map.Polyline(
        color: Colors.deepPurple,
        points: polylineCoordicates,
        strokeWidth: 2,
      );
    }

    return FutureBuilder(
      future: mapData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 500,
            child: map.FlutterMap(
              options: map.MapOptions(
                // initialCenter: LatLng(51.509364, -0.128928),
                // initialZoom: 3,
                initialCameraFit: map.CameraFit.bounds(
                  bounds: getBounds(snapshot.data!.locations),
                  padding: const EdgeInsets.all(10),
                ),
                interactionOptions: const map.InteractionOptions(
                  //Zoom과 드래그 이동만 가능하도록 설정
                  flags:
                      map.InteractiveFlag.pinchZoom | map.InteractiveFlag.drag,
                ),
              ),
              children: [
                map.TileLayer(
                  urlTemplate:
                      'https://server.arcgisonline.com/ArcGIS/rest/services/World_Street_Map/MapServer/tile/{z}/{y}/{x}',
                  userAgentPackageName: 'com.example.app',
                ),
                map.MarkerLayer(
                  markers: getMarkers(snapshot.data!.locations),
                ),
                map.PolylineLayer(
                  polylines: [getPaths(snapshot.data!.paths)],
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: Theme.of(context).colorScheme.outline,
              size: 50,
            ),
          );
        }
      },
    );
  }
}
