import 'package:route_planner/enums/weather_category.dart';

enum WeatherCondition {
  unknown('unknown', WeatherCategory.unknown),
  // Group 2xx: Thunderstorm
  thunderstormWithLightRain(
    'thunderstorm with light rain',
    WeatherCategory.thunderstorm,
  ),
  thunderstormWithRain('thunderstorm with rain', WeatherCategory.thunderstorm),
  thunderstormWithHeavyRain(
    'thunderstorm with heavy rain',
    WeatherCategory.thunderstorm,
  ),
  lightThunderstorm('light thunderstorm', WeatherCategory.thunderstorm),
  thunderstorm('thunderstorm', WeatherCategory.thunderstorm),
  heavyThunderstorm('heavy thunderstorm', WeatherCategory.thunderstorm),
  raggedThunderstorm('ragged thunderstorm', WeatherCategory.thunderstorm),
  thunderstormWithLightDrizzle(
    'thunderstorm with light drizzle',
    WeatherCategory.thunderstorm,
  ),
  thunderstormWithDrizzle(
    'thunderstorm with drizzle',
    WeatherCategory.thunderstorm,
  ),
  thunderstormWithHeavyDrizzle(
    'thunderstorm with heavy drizzle',
    WeatherCategory.thunderstorm,
  ),

  // Group 3xx: Drizzle
  lightIntensityDrizzle('light intensity drizzle', WeatherCategory.rain),
  drizzle('drizzle', WeatherCategory.rain),
  heavyIntensityDrizzle('heavy intensity drizzle', WeatherCategory.rain),
  lightIntensityDrizzleRain(
    'light intensity drizzle rain',
    WeatherCategory.rain,
  ),
  drizzleRain('drizzle rain', WeatherCategory.rain),
  heavyIntensityDrizzleRain(
    'heavy intensity drizzle rain',
    WeatherCategory.rain,
  ),
  showerRainAndDrizzle('shower rain and drizzle', WeatherCategory.rain),
  heavyShowerRainAndDrizzle(
    'heavy shower rain and drizzle',
    WeatherCategory.rain,
  ),
  showerDrizzle('shower drizzle', WeatherCategory.rain),

  // Group 5xx: Rain
  lightRain('light rain', WeatherCategory.rain),
  moderateRain('moderate rain', WeatherCategory.rain),
  heavyIntensityRain('heavy intensity rain', WeatherCategory.rain),
  veryHeavyRain('very heavy rain', WeatherCategory.rain),
  extremeRain('extreme rain', WeatherCategory.rain),
  freezingRain('freezing rain', WeatherCategory.rain),
  lightIntensityShowerRain('light intensity shower rain', WeatherCategory.rain),
  showerRain('shower rain', WeatherCategory.rain),
  heavyIntensityShowerRain('heavy intensity shower rain', WeatherCategory.rain),
  raggedShowerRain('ragged shower rain', WeatherCategory.rain),

  // Group 6xx: Snow
  lightSnow('light snow', WeatherCategory.snow),
  snow('snow', WeatherCategory.snow),
  heavySnow('heavy snow', WeatherCategory.snow),
  sleet('sleet', WeatherCategory.snow),
  lightShowerSleet('light shower sleet', WeatherCategory.snow),
  showerSleet('shower sleet', WeatherCategory.snow),
  lightRainAndSnow('light rain and snow', WeatherCategory.snow),
  rainAndSnow('rain and snow', WeatherCategory.snow),
  lightShowerSnow('light shower snow', WeatherCategory.snow),
  showerSnow('shower snow', WeatherCategory.snow),
  heavyShowerSnow('heavy shower snow', WeatherCategory.snow),

  // Group 7xx: Atmosphere
  mist('mist', WeatherCategory.fog),
  smoke('smoke', WeatherCategory.fog),
  haze('haze', WeatherCategory.fog),
  sandDustWhirls('sand/dust whirls', WeatherCategory.fog),
  fog('fog', WeatherCategory.fog),
  sand('sand', WeatherCategory.fog),
  dust('dust', WeatherCategory.fog),
  volcanicAsh('volcanic ash', WeatherCategory.fog),
  squalls('squalls', WeatherCategory.fog),
  tornado('tornado', WeatherCategory.fog),

  // Group 800: Clear
  clearSky('clear sky', WeatherCategory.clear),

  // Group 80x: Clouds
  fewClouds('few clouds', WeatherCategory.clouds),
  scatteredClouds('scattered clouds', WeatherCategory.clouds),
  brokenClouds('broken clouds', WeatherCategory.clouds),
  overcastClouds('overcast clouds', WeatherCategory.clouds);

  final String value;
  final WeatherCategory weatherCategory;

  const WeatherCondition(this.value, this.weatherCategory);

  factory WeatherCondition.fromString(String value) {
    for (var condition in WeatherCondition.values) {
      if (condition.value.toLowerCase() == value.toLowerCase()) {
        return condition;
      }
    }
    throw Exception('Invalid weather condition: $value');
  }
}
