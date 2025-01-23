import 'location_mock.dart';
import 'network_service_mock.dart';
import 'weather_model_mock.dart';

class WeatherRepositoryMock {
  final NetworkServiceMock networkService;
  final Map<String, WeatherModelMock> _weatherCache = {};

  WeatherRepositoryMock(this.networkService);

  Future<WeatherModelMock> getWeather(LocationMock location) async {
    final locationKey = '${location.latitude},${location.longitude}';
    if (_weatherCache.containsKey(locationKey)) {
      return _weatherCache[locationKey]!;
    } else {
      final weather = await networkService.getWeather(location);
      _weatherCache[locationKey] = weather;
      return weather;
    }
  }

  Map<String, WeatherModelMock> get weatherCache => _weatherCache;
}
