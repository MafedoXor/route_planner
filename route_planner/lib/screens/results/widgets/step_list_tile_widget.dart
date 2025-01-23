import 'package:flutter/material.dart';
import 'package:route_planner/api/network_service.dart';
import 'package:route_planner/enums/side.dart';
import 'package:route_planner/enums/weather_category.dart';
import 'package:route_planner/models/route_step_model.dart';
import 'package:route_planner/models/weather_model.dart';

class StepListTileWidget extends StatefulWidget {
  final RouteStep step;

  //uncomment to use lazy loading
  // final WeatherModel weatherModel;

  const StepListTileWidget({
    super.key,
    required this.step,
    //uncomment to use lazy loading
    // required this.weatherModel,
  });

  @override
  State<StepListTileWidget> createState() => _StepListTileWidgetState();
}

class _StepListTileWidgetState extends State<StepListTileWidget> {
  //comment out to use lazy loading
  final NetworkService _networkService = NetworkService();

  //need logic to clear cache
  static final Map<String, WeatherModel> _weatherCache = {};

  WeatherModel? weatherModel;

  Future<WeatherModel> _fetchWeather() async {
    final locationKey =
        '${widget.step.location.latitude},${widget.step.location.longitude}';
    if (_weatherCache.containsKey(locationKey)) {
      return _weatherCache[locationKey]!;
    } else {
      final weather = await _networkService.getWeather(widget.step.location);
      _weatherCache[locationKey] = weather;
      return weather;
    }
  }

  @override
  Widget build(BuildContext context) {
    IconData selectDirectionIcon() {
      return widget.step.direction == null
          ? Icons.question_mark
          : widget.step.direction!.category == Side.start
              ? Icons.mode_standby
              : widget.step.direction!.category == Side.right
                  ? Icons.arrow_forward
                  : widget.step.direction!.category == Side.left
                      ? Icons.arrow_back
                      : widget.step.direction!.category == Side.straight
                          ? Icons.arrow_upward
                          : Icons.question_mark;
    }

    IconData selectWeatherIcon() {
      return weatherModel!.description.weatherCategory == WeatherCategory.clear
          ? Icons.circle_outlined
          : weatherModel!.description.weatherCategory == WeatherCategory.rain
              ? Icons.grain
              : weatherModel!.description.weatherCategory ==
                      WeatherCategory.snow
                  ? Icons.ac_unit
                  : weatherModel!.description.weatherCategory ==
                          WeatherCategory.clouds
                      ? Icons.cloud
                      : weatherModel!.description.weatherCategory ==
                              WeatherCategory.thunderstorm
                          ? Icons.flash_on
                          : weatherModel!.description.weatherCategory ==
                                  WeatherCategory.fog
                              ? Icons.foggy
                              : weatherModel!.description.weatherCategory ==
                                      WeatherCategory.sun
                                  ? Icons.wb_sunny
                                  : Icons.question_mark;
    }

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
                  //round to 4 decimal places
                  Text(
                    'Latitude: ${widget.step.location.latitude.toStringAsFixed(6)}°',
                  ),
                  Text(
                    'Longitude: ${widget.step.location.longitude.toStringAsFixed(6)}°',
                  ),
                ],
              ),
              //uncomment to use lazy loading
              // Column(
              //   children: [
              //     Icon(
              //       selectWeatherIcon(),
              //       color: Colors.blueGrey,
              //     ),
              //     SizedBox(
              //       width: 100,
              //       child: Text(
              //         weatherModel!.description.value,
              //         maxLines: 3,
              //         textAlign: TextAlign.center,
              //       ),
              //     ),
              //   ],
              // ),
              //comment out to use lazy loading
              FutureBuilder(
                future: _fetchWeather(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error fetching weather data');
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
                                  weatherModel!.description.value,
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
