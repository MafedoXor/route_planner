import 'package:route_planner/enums/weather_condition_enum.dart';

class WeatherModel {
  final WeatherCondition description;
  final double temperature;

  WeatherModel({
    required this.description,
    required this.temperature,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      description: WeatherCondition.fromString(json['description']),
      temperature: json['temperature'].toDouble(),
    );
  }

  factory WeatherModel.$default() {
    return WeatherModel(
      description: WeatherCondition.unknown,
      temperature: 0,
    );
  }
}
