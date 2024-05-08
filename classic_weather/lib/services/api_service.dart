// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:sarcastic_weather/controller/home_controller.dart';
import 'package:sarcastic_weather/models/cities_model.dart';
import 'package:sarcastic_weather/models/weather_model.dart';

import '../app_constants.dart';
import '../models/forecast_model.dart';
import '../models/response_model.dart';

class ApiService {
  //WEATHER API
  static const WEATHER_BASE_URL = AppConstants.WEATHER_API_BASE_URL;
  static const FORECAST_BASE_URL = AppConstants.FORECAST_API_URL;
  static const WEATHER_API_ID = AppConstants.WEATHER_API_ID;

  //CITIES API
  static const AUTOCOMPLETE_BASE_URL = AppConstants.CITIES_API_BASE_URL;
  static const AUTOCOMPLETE_API_ID = AppConstants.CITIES_API_ID;

  // get location of user automatically

  Future<Position> getUserCity() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    return position;
  }

  // get weather of that location automatically by lat and long

  Future<WeatherModel> getWeatherFromUserLocation(
      double latitude, double longitude) async {
    print(" POSTITION $latitude  $longitude");
    final response = await http.get(Uri.parse(
        "$WEATHER_BASE_URL?&appid=$WEATHER_API_ID&units=metric&lat=$latitude&lon=$longitude"));
    print(response.body);
    if (response.statusCode == 200) {
      return WeatherModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      print("Failed to load weather");
      final homeController = Get.find<HomeController>();
      homeController.isErrorOccurred.value = true;
      throw Exception("Failed to load weather");
    }
  }
  // get forecast for 5 days

  Future<WeatherForecastModel> getForecastFromUserLocation(
      double latitude, double longitude) async {
    print("FORECAST ");
    final response = await http.get(Uri.parse(
        "$FORECAST_BASE_URL?&appid=$WEATHER_API_ID&units=metric&lat=$latitude&lon=$longitude"));
    print(response.body);
    if (response.statusCode == 200) {
      return WeatherForecastModel.fromJson(
        jsonDecode(response.body),
      );
    } else {
      print("Failed to load weather");
      final homeController = Get.find<HomeController>();
      homeController.isErrorOccurred.value = true;
      throw Exception("Failed to load weather");
    }
  }

  //get  city suggestions from search

  Future<ResponseModel> getCitySuggestions(String text) async {
    final response = await http.get(Uri.parse(
        "$AUTOCOMPLETE_BASE_URL?text=$text&apiKey=$AUTOCOMPLETE_API_ID"));
    print(response.body);
    if (response.statusCode == 200) {
      return ResponseModel(
        statusCode: 200,
        message: null,
        data: CityAutocompleteModel.fromJson(
          jsonDecode(response.body),
        ),
      );
    } else {
      print("Failed to load cities suggestions");
      // throw Exception("Failed to load suggestions");
      return ResponseModel(
          statusCode: 404, message: "Error has occurred", data: {});
    }
  }
}
