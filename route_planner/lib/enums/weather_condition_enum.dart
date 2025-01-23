enum WeatherCondition {
  unknown('unknown'),

// Group 2xx: Thunderstorm
  thunderstormWithLightRain('thunderstorm with light rain'),
  thunderstormWithRain('thunderstorm with rain'),
  thunderstormWithHeavyRain('thunderstorm with heavy rain'),
  lightThunderstorm('light thunderstorm'),
  thunderstorm('thunderstorm'),
  heavyThunderstorm('heavy thunderstorm'),
  raggedThunderstorm('ragged thunderstorm'),
  thunderstormWithLightDrizzle('thunderstorm with light drizzle'),
  thunderstormWithDrizzle('thunderstorm with drizzle'),
  thunderstormWithHeavyDrizzle('thunderstorm with heavy drizzle'),

// Group 3xx: Drizzle
  lightIntensityDrizzle('light intensity drizzle'),
  drizzle('drizzle'),
  heavyIntensityDrizzle('heavy intensity drizzle'),
  lightIntensityDrizzleRain('light intensity drizzle rain'),
  drizzleRain('drizzle rain'),
  heavyIntensityDrizzleRain('heavy intensity drizzle rain'),
  showerRainAndDrizzle('shower rain and drizzle'),
  heavyShowerRainAndDrizzle('heavy shower rain and drizzle'),
  showerDrizzle('shower drizzle'),

// Group 5xx: Rain
  lightRain('light rain'),
  moderateRain('moderate rain'),
  heavyIntensityRain('heavy intensity rain'),
  veryHeavyRain('very heavy rain'),
  extremeRain('extreme rain'),
  freezingRain('freezing rain'),
  lightIntensityShowerRain('light intensity shower rain'),
  showerRain('shower rain'),
  heavyIntensityShowerRain('heavy intensity shower rain'),
  raggedShowerRain('ragged shower rain'),

// Group 6xx: Snow
  lightSnow('light snow'),
  snow('snow'),
  heavySnow('heavy snow'),
  sleet('sleet'),
  lightShowerSleet('light shower sleet'),
  showerSleet('shower sleet'),
  lightRainAndSnow('light rain and snow'),
  rainAndSnow('rain and snow'),
  lightShowerSnow('light shower snow'),
  showerSnow('shower snow'),
  heavyShowerSnow('heavy shower snow'),

// Group 7xx: Atmosphere
  mist('mist'),
  smoke('smoke'),
  haze('haze'),
  sandDustWhirls('sand/dust whirls'),
  fog('fog'),
  sand('sand'),
  dust('dust'),
  volcanicAsh('volcanic ash'),
  squalls('squalls'),
  tornado('tornado'),

// Group 800: Clear
  clearSky('clear sky'),

// Group 80x: Clouds
  fewClouds('few clouds'),
  scatteredClouds('scattered clouds'),
  brokenClouds('broken clouds'),
  overcastClouds('overcast clouds');

  final String value;

  const WeatherCondition(this.value);

  factory WeatherCondition.fromString(String value) {
    for (var condition in WeatherCondition.values) {
      if (condition.value.toLowerCase() == value.toLowerCase()) {
        return condition;
      }
    }
    throw Exception('Invalid weather condition: $value');
  }
}
