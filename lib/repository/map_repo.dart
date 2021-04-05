import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_doctors_apps/helper/request_helper.dart';
import 'package:mobile_doctors_apps/model/direction_detail.dart';

abstract class IMapRepo {
  Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition);
}

class MapRepo extends IMapRepo {
  @override
  Future<DirectionDetails> getDirectionDetails(
      LatLng startPosition, LatLng endPosition) async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${startPosition.latitude},${startPosition.longitude}&destination=${endPosition.latitude},${endPosition.longitude}&mode=driving&key=AIzaSyDccJwe-72W30lGDAhHM98DHjqESsfInUg';

    var response = await RequestHealper.getRequest(url);

    if (response == 'failed') {
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.durationText =
        response['routes'][0]['legs'][0]['duration']['text'];
    directionDetails.durationValue =
        response['routes'][0]['legs'][0]['duration']['value'];

    directionDetails.distanceText =
        response['routes'][0]['legs'][0]['distance']['text'];
    directionDetails.distanceValue =
        response['routes'][0]['legs'][0]['distance']['value'];

    directionDetails.encodePoints =
        response['routes'][0]['overview_polyline']['points'];

    return directionDetails;
  }
}
