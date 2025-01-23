import 'package:route_planner/enums/weather_condition_enum.dart';

enum WeatherCategory {
  unknown,
  thunderstorm,
  rain,
  snow,
  fog,
  clouds,
  clear,
  sun;

  factory WeatherCategory.fromWeatherCondition(
    WeatherCondition weatherCondition,
  ) {
    switch (weatherCondition) {
      case WeatherCondition.thunderstormWithLightRain:
      case WeatherCondition.thunderstormWithRain:
      case WeatherCondition.thunderstormWithHeavyRain:
      case WeatherCondition.lightThunderstorm:
      case WeatherCondition.thunderstorm:
      case WeatherCondition.heavyThunderstorm:
      case WeatherCondition.raggedThunderstorm:
      case WeatherCondition.thunderstormWithLightDrizzle:
      case WeatherCondition.thunderstormWithDrizzle:
      case WeatherCondition.thunderstormWithHeavyDrizzle:
        return WeatherCategory.thunderstorm;
      case WeatherCondition.lightIntensityDrizzle:
      case WeatherCondition.drizzle:
      case WeatherCondition.heavyIntensityDrizzle:
      case WeatherCondition.lightIntensityDrizzleRain:
      case WeatherCondition.drizzleRain:
      case WeatherCondition.heavyIntensityDrizzleRain:
      case WeatherCondition.showerRainAndDrizzle:
      case WeatherCondition.heavyShowerRainAndDrizzle:
      case WeatherCondition.showerDrizzle:
        return WeatherCategory.rain;
      case WeatherCondition.lightRain:
      case WeatherCondition.moderateRain:
      case WeatherCondition.heavyIntensityRain:
      case WeatherCondition.veryHeavyRain:
      case WeatherCondition.extremeRain:
      case WeatherCondition.freezingRain:
      case WeatherCondition.lightIntensityShowerRain:
      case WeatherCondition.showerRain:
        return WeatherCategory.rain;
      case WeatherCondition.lightSnow:
      case WeatherCondition.snow:
      case WeatherCondition.heavySnow:
      case WeatherCondition.sleet:
      case WeatherCondition.lightShowerSleet:
      case WeatherCondition.showerSleet:
      case WeatherCondition.lightRainAndSnow:
      case WeatherCondition.rainAndSnow:
      case WeatherCondition.lightShowerSnow:
      case WeatherCondition.showerSnow:
      case WeatherCondition.heavyShowerSnow:
        return WeatherCategory.snow;
      case WeatherCondition.mist:
      case WeatherCondition.smoke:
      case WeatherCondition.haze:
      case WeatherCondition.sandDustWhirls:
      case WeatherCondition.fog:
      case WeatherCondition.sand:
      case WeatherCondition.dust:
      case WeatherCondition.volcanicAsh:
      case WeatherCondition.squalls:
      case WeatherCondition.tornado:
        return WeatherCategory.fog;
      case WeatherCondition.clearSky:
        return WeatherCategory.clear;
      case WeatherCondition.fewClouds:
      case WeatherCondition.scatteredClouds:
      case WeatherCondition.brokenClouds:
      case WeatherCondition.overcastClouds:
        return WeatherCategory.clouds;
      default:
        return WeatherCategory.unknown;
    }
  }
}
