import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../models/forecast_model.dart';
import '../models/weather_model.dart';
import '../services/api_service.dart';

class HomeController extends GetxController {
  final apiService = ApiService();
  var isLocationAccessAllowed = true.obs;
  var isErrorOccurred = true.obs;
  var isLoading = false.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  var weatherModel = WeatherModel().obs;
  var forecastModel = WeatherForecastModel().obs;
  @override
  void onReady() async {
    super.onReady();
    checkLocationAccess();
    await getWeatherInformationByLocation();
  }

  checkLocationAccess() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      isLocationAccessAllowed.value = false;
    }
  }

  Future<WeatherModel> getWeatherInformationByLocation() async {
    isLoading.value = true;
    final position = await apiService.getUserCity();
    isLocationAccessAllowed.value = true;
    latitude.value = position.latitude;
    longitude.value = position.longitude;

    final weatherInfo = await apiService.getWeatherFromUserLocation(
        latitude.value, longitude.value);
    await getWeatherForecastData();
    weatherModel.value = weatherInfo;
    isLoading.value = false;
    update();
    return weatherInfo;
  }

  Future<WeatherForecastModel> getWeatherForecastData() async {
    final forecastInfo = await apiService.getForecastFromUserLocation(
        latitude.value, longitude.value);
    forecastModel.value = forecastInfo;
    return forecastInfo;
  }

  Future<WeatherModel> getSearchWeatherInformation() async {
    isLoading.value = true;
    if (latitude.value != 0 && longitude.value != 0) {
      final weatherInfo = await apiService.getWeatherFromUserLocation(
          latitude.value, longitude.value);
      await getWeatherForecastData();
      weatherModel.value = weatherInfo;
      isLoading.value = false;
      return weatherInfo;
    }
    return WeatherModel();
  }
}
