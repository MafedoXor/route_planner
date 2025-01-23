import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:route_planner/api/api_endpoints.dart';
import 'package:route_planner/models/location.dart';
import 'package:route_planner/models/route_model.dart';
import 'package:route_planner/models/weather_model.dart';

class NetworkService {
  Future<RouteModel?> getRoutes(
    String originCity,
    String destinationCity,
  ) async {
    final headers = {'Accept': 'application/json'};

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiEndPoint.ROUTES}/$originCity/$destinationCity',
        ),
        headers: headers,
      );

      final responseJson = parseResponse(response);
      if (responseJson != null) {
        final decodedJson = jsonDecode(responseJson);

        return decodedJson != null ? RouteModel.fromJson(decodedJson) : null;
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print(e);
    }

    return null;
  }

  Future<WeatherModel> getWeather(Location location) async {
    final headers = {'Accept': 'application/json'};

    try {
      final response = await http.get(
        Uri.parse(
          '${ApiEndPoint.WEATHER}/${location.latitude}/${location.longitude}',
        ),
        headers: headers,
      );

      final responseJson = parseResponse(response);
      if (responseJson != null) {
        final decodedJson = jsonDecode(responseJson);

        return decodedJson != null
            ? WeatherModel.fromJson(decodedJson)
            : WeatherModel.$default();
      }
    } on SocketException {
      throw Exception('No Internet Connection');
    } catch (e) {
      print(e);
    }

    return WeatherModel.$default();
  }

  String? parseResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return response.body;
      default:
        print('Error: ${response.reasonPhrase}');
        return null;
    }
  }
}
