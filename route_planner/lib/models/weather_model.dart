import 'package:route_planner/enums/weather_condition_enum.dart';

class WeatherModel {
  final WeatherCondition condition;
  final double temperature;

  WeatherModel({
    required this.condition,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      condition: WeatherCondition.fromString(json['description']),
      temperature: json['temperature'].toDouble(),
    );
  }

  factory WeatherModel.$default() {
    return WeatherModel(
      condition: WeatherCondition.unknown,
      temperature: 0,
    );
  }
}
