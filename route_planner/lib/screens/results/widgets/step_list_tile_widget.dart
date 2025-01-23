import 'package:flutter/material.dart';
import 'package:route_planner/api/network_service.dart';
import 'package:route_planner/enums/side.dart';
import 'package:route_planner/enums/weather_category.dart';
import 'package:route_planner/models/route_step_model.dart';
import 'package:route_planner/models/weather_model.dart';

class StepListTileWidget extends StatefulWidget {
  final RouteStep step;

  const StepListTileWidget({
    super.key,
    required this.step,
  });

  @override
  State<StepListTileWidget> createState() => _StepListTileWidgetState();
}

class _StepListTileWidgetState extends State<StepListTileWidget> {
  static final Map<String, WeatherModel> _weatherCache = {};

  late final Future<WeatherModel> weatherData;

  WeatherModel? weatherModel;

  @override
  void initState() {
    super.initState();

    weatherData = _fetchWeather();
  }

  Future<WeatherModel> _fetchWeather() async {
    final locationKey =
        '${widget.step.location.latitude},${widget.step.location.longitude}';
    if (_weatherCache.containsKey(locationKey)) {
      return _weatherCache[locationKey]!;
    } else {
      final weather = await networkService.getWeather(widget.step.location);
      _weatherCache[locationKey] = weather;
      return weather;
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData selectDirectionIcon() {
      if (widget.step.direction == null) {
        return Icons.question_mark;
      }

      switch (Side.fromDirection(widget.step.direction!)) {
        case Side.start:
          return Icons.mode_standby;
        case Side.right:
          return Icons.arrow_forward;
        case Side.left:
          return Icons.arrow_back;
        case Side.straight:
          return Icons.arrow_upward;
        default:
          return Icons.question_mark;
      }
    }

    IconData selectWeatherIcon() {
      switch (WeatherCategory.fromWeatherCondition(weatherModel!.condition)) {
        case WeatherCategory.clear:
          return Icons.circle_outlined;
        case WeatherCategory.rain:
          return Icons.grain;
        case WeatherCategory.snow:
          return Icons.ac_unit;
        case WeatherCategory.clouds:
          return Icons.cloud;
        case WeatherCategory.thunderstorm:
          return Icons.flash_on;
        case WeatherCategory.fog:
          return Icons.foggy;
        case WeatherCategory.sun:
          return Icons.wb_sunny;
        default:
          return Icons.question_mark;
      }
    }

    const String latitudeText = 'Latitude: ${0}°';
    const String longitudeText = 'Longitude: ${0}°';
    const String errorFetchWeather = 'Error fetching weather data';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            selectDirectionIcon(),
            color: Colors.blueGrey,
          ),
          Text(widget.step.direction?.value ?? 'Unknown'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    latitudeText.replaceFirst(
                      '${0}',
                      widget.step.location.latitude.toStringAsFixed(6),
                    ),
                  ),
                  Text(
                    longitudeText.replaceFirst(
                      '${0}',
                      widget.step.location.longitude.toStringAsFixed(6),
                    ),
                  ),
                ],
              ),
              FutureBuilder(
                future: weatherData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Text(errorFetchWeather);
                    } else {
                      weatherModel = snapshot.data as WeatherModel;
                      return Row(
                        children: [
                          Column(
                            children: [
                              Icon(
                                selectWeatherIcon(),
                                color: Colors.blueGrey,
                              ),
                              SizedBox(
                                width: 100,
                                child: Text(
                                  weatherModel!.condition.value,
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '${weatherModel!.temperature}C°',
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
