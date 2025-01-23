import 'package:route_planner/api/network_service.dart';
import 'package:route_planner/models/location.dart';
import 'package:route_planner/models/weather_model.dart';

final WeatherRepository weatherRepository = WeatherRepository();

class WeatherRepository {
  final Map<String, WeatherModel> _weatherCache = {};

  Future<WeatherModel> getWeather(Location location) async {
    final locationKey = '${location.latitude},${location.longitude}';
    if (_weatherCache.containsKey(locationKey)) {
      return _weatherCache[locationKey]!;
    } else {
      final weather = await networkService.getWeather(location);
      _weatherCache[locationKey] = weather;
      return weather;
    }
  }
}
