import 'location_mock.dart';
import 'weather_model_mock.dart';

class NetworkServiceMock {
  Future<WeatherModelMock> getWeather(LocationMock location) async {
    return WeatherModelMock.$default(); // Default mock response
  }
}
