import 'package:route_planner/enums/weather_condition_enum.dart';
import 'package:route_planner/models/weather_model.dart';

class WeatherModelMock extends WeatherModel {
  WeatherModelMock({required super.condition, required super.temperature});

  factory WeatherModelMock.$default() {
    return WeatherModelMock(
      condition: WeatherCondition.clearSky,
      temperature: 25,
    );
  }
}
