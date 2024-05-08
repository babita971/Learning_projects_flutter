// ignore_for_file: constant_identifier_names

class AppConstants {
  static const WEATHER_API_ID = "acf0168c8fd7d588ad4b59f3f20b54d7";
  static const WEATHER_API_BASE_URL =
      "https://api.openweathermap.org/data/2.5/weather";
  static const FORECAST_API_URL =
      "https://api.openweathermap.org/data/2.5/forecast?";

  static const CITIES_API_ID = "ae052dc39af345948cd7a828405bf53c";
  static const CITIES_API_BASE_URL =
      "https://api.geoapify.com/v1/geocode/autocomplete";

  static const SUNNY = "sunny";
  static const CLOUDY_MISTY = "cloudy_misty";
  static const CLOUDY_SNOWY = "cloudy_snowy";
  static const CLOUDY = "cloudy";
  static const PARTLY_CLOUDY = "partly_cloudy";
  static const PARTLY_SHOWER = "partly_shower";
  static const RAIN_STORM = "rain_storm";
  static const SUNNY_SNOWY = "sunny_snowy";
  static const THUNDER = "thunder";
  static const LOADING = "loading";
  static const OVERCAST = "overcast";
  static const LIGHT = "light";

  static const APP_ANIMATIONS = {
    SUNNY: "sunny.json",
    CLOUDY_MISTY: "cloudy_misty.json",
    CLOUDY_SNOWY: "cloudy_snowy.json",
    CLOUDY: "cloudy.json",
    PARTLY_CLOUDY: "partly_cloudy.json",
    PARTLY_SHOWER: "partly_shower.json",
    RAIN_STORM: "rain_storm.json",
    SUNNY_SNOWY: "sunny_snowy.json",
    THUNDER: "thunder.json",
    LOADING: "loading.json"
  };
}

class WeatherTypes {
  static const CLEAR = "clear";
  static const CLOUDS = "clouds";
  static const SNOW = "snow";
  static const RAIN = "rain";
  static const HAZE = "haze";
  static const MIST = "mist";
  static const SMOKE = "smoke";
  static const THUNDERSTORM = "Thunderstorm";
}
