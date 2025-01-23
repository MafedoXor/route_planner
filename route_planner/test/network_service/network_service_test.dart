import 'package:flutter_test/flutter_test.dart';
import 'package:route_planner/enums/weather_condition_enum.dart';

import '../mocks/location_mock.dart';
import '../mocks/network_service_mock.dart';
import '../mocks/weather_model_mock.dart';
import '../mocks/weather_repository_mock.dart';

void main() {
  late WeatherRepositoryMock weatherRepository;
  late NetworkServiceMock mockNetworkService;

  setUp(() {
    mockNetworkService = NetworkServiceMock();
    weatherRepository = WeatherRepositoryMock(mockNetworkService);
  });

  test('Should fetch weather from network when not in cache', () async {
    // Arrange
    final location = LocationMock.$default();

    // Act
    final result = await weatherRepository.getWeather(location);

    // Assert
    expect(result.condition, WeatherCondition.clearSky);
    expect(result.temperature, 25);
  });

  test('Should return cached weather if available', () async {
    // Arrange
    final location = LocationMock.$default();
    final weather = WeatherModelMock.$default();
    weatherRepository.weatherCache['5.0,5.0'] = weather;

    // Act
    final result = await weatherRepository.getWeather(location);

    // Assert
    expect(result.condition, WeatherCondition.clearSky);
    expect(result.temperature, 25);
  });

  test('Should cache the weather after fetching from network', () async {
    // Arrange
    final location = LocationMock.$default();

    // Act
    final result = await weatherRepository.getWeather(location);

    // Assert
    expect(weatherRepository.weatherCache['5.0,5.0'], result);
  });
}
