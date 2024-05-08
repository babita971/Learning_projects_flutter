import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sarcastic_weather/app_constants.dart';
import 'package:sarcastic_weather/controller/home_controller.dart';
import 'package:sarcastic_weather/screens/city_search_delegate.dart';
import 'package:intl/intl.dart';
import '../models/forecast_model.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  String getAnimation(String mainMessage, String mainDescription) {
    switch (mainMessage) {
      case WeatherTypes.CLEAR:
        return AppConstants.APP_ANIMATIONS[AppConstants.SUNNY] ?? "";

      case WeatherTypes.CLOUDS:
        //if description has light, show light else thunder rain
        return AppConstants.APP_ANIMATIONS[
                mainDescription.contains(AppConstants.OVERCAST)
                    ? AppConstants.CLOUDY
                    : AppConstants.PARTLY_CLOUDY] ??
            "";

      case WeatherTypes.SNOW:
        //sunny_snowy
        return AppConstants.APP_ANIMATIONS[AppConstants.CLOUDY_SNOWY] ?? "";

      case WeatherTypes.RAIN:
        //Light moderate and heavy rain
        return AppConstants.APP_ANIMATIONS[
                mainDescription.contains(AppConstants.LIGHT)
                    ? AppConstants.PARTLY_SHOWER
                    : AppConstants.RAIN_STORM] ??
            "";

      case WeatherTypes.HAZE:
      case WeatherTypes.MIST:
      case WeatherTypes.SMOKE:
        return AppConstants.APP_ANIMATIONS[AppConstants.CLOUDY_MISTY] ?? "";

      case WeatherTypes.THUNDERSTORM:
        return AppConstants.APP_ANIMATIONS[AppConstants.THUNDER] ?? "";

      default:
        return AppConstants.APP_ANIMATIONS[AppConstants.LOADING] ?? "";
    }
  }

  //Depending on your weather model result from api, show the UI to user
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("A Classic Weather App"),
          leading: const SizedBox(),
          actions: [
            IconButton(
              onPressed: () async {
                await showSearch(
                  context: context,
                  delegate: CitySearchDelegate(),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
          // backgroundColor: Colors.orangeAccent,
          bottom: const TabBar(
            dividerHeight: 0,
            tabs: [
              Text(
                "Today",
                style: TextStyle(fontSize: 16),
              ),
              Text(
                "Forecast",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            getWeatherWidget(context),
            getForecastWidget(),
          ],
        ),
      ),
    );
  }

  getWeatherWidget(BuildContext context) {
    return Obx(
      () {
        controller.isLoading.value;
        controller.isLocationAccessAllowed.value;
        controller.weatherModel.value;
        return controller.isLocationAccessAllowed.value
            ? AnimatedSwitcher(
                duration: const Duration(milliseconds: 1500),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return ScaleTransition(scale: animation, child: child);
                },
                child: Center(
                  key: UniqueKey(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.isLoading.value
                        ? [
                            const CircularProgressIndicator(
                              color: Colors.amberAccent,
                              strokeWidth: 4,
                            )
                          ]
                        : [
                            Text(
                              "${controller.weatherModel.value.city}",
                              style: const TextStyle(
                                fontSize: 24,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              "${controller.weatherModel.value.temperature.toString()}° C",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Lottie.asset(
                                "assets/animations/${getAnimation(controller.weatherModel.value.mainTitle != null ? controller.weatherModel.value.mainTitle!.toLowerCase() : "", controller.weatherModel.value.mainDescription != null ? controller.weatherModel.value.mainDescription!.toLowerCase() : "")}"),
                            Text(
                              "${controller.weatherModel.value.mainTitle}",
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                  ),
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.add_location_alt_sharp,
                        size: 48,
                        color: Colors.deepOrangeAccent,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Location access is disabled.",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              var status = await Permission.location.request();
                              if (status == PermissionStatus.granted) {
                                controller.isLocationAccessAllowed.value = true;
                                controller.getWeatherInformationByLocation();
                              }
                              if (status ==
                                      PermissionStatus.permanentlyDenied ||
                                  status == PermissionStatus.denied) {
                                openAppSettings();
                              }
                            },
                            child: const Text(
                              "Turn on",
                              style: TextStyle(
                                color: Colors.deepOrangeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepOrangeAccent,
                            ),
                            onPressed: () async {
                              var status = await Permission.location.status;
                              print(status);
                              if (status == PermissionStatus.granted ||
                                  status == PermissionStatus.limited) {
                                controller.isLocationAccessAllowed.value = true;
                                controller.getWeatherInformationByLocation();
                              } else {
                                // ignore: use_build_context_synchronously
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                            "Location access is not given."),
                                        content: const Text(
                                            "Please enable location access."),
                                        actions: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Okay",
                                              style: TextStyle(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              }
                            },
                            child: const Text(
                              "Refresh",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              );
      },
    );
  }

  getForecastWidget() {
    return Obx(() {
      if (controller.forecastModel.value.cod == "200") {
        var forecastList = controller.forecastModel.value.forecastList;
        return Container(
          color: const Color(0xFFedf2fb),
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              var today = DateTime.now().add(Duration(days: index));
              List<ForecastList> list = forecastList!
                  .where(
                    (element) => (today.day == element.dtTxt!.day &&
                        today.year == element.dtTxt!.year &&
                        today.month == element.dtTxt!.month),
                  )
                  .toList();
              return getListTileWidget(list);
            },
          ),
        );
      }
      return const Center(
        child: Text(
          'Oops. An error has occurred!',
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      );
    });
  }

  getListTileWidget(List<ForecastList> weatherWithTimeList) {
    var today = DateTime.now();
    var date = today.day == weatherWithTimeList[0].dtTxt!.day &&
            today.year == weatherWithTimeList[0].dtTxt!.year &&
            today.month == weatherWithTimeList[0].dtTxt!.month
        ? "Today"
        : today.day + 1 == weatherWithTimeList[0].dtTxt!.day &&
                today.year == weatherWithTimeList[0].dtTxt!.year &&
                today.month == weatherWithTimeList[0].dtTxt!.month
            ? "Tomorrow"
            : DateFormat.yMMMMd().format(weatherWithTimeList[0].dtTxt!);

    return Container(
      margin: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          getAnimation(
                      weatherWithTimeList[0].weather![0].main!.toLowerCase(),
                      weatherWithTimeList[0]
                          .weather![0]
                          .description!
                          .toLowerCase()) ==
                  "sunny.json"
              ? Colors.amberAccent
              : Colors.grey,
          Colors.white,
        ], begin: Alignment.topLeft, end: Alignment.bottomCenter),
      ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.white,
        tilePadding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
        shape: const Border(),
        leading: CircleAvatar(
          radius: 60,
          backgroundColor: Colors.white,
          child: Lottie.asset(
              "assets/animations/${getAnimation(weatherWithTimeList[0].weather![0].main!.toLowerCase(), weatherWithTimeList[0].weather![0].description!.toLowerCase())}"),
        ),
        trailing: Padding(
          padding: const EdgeInsets.only(left: 8.0, right :8.0),
          child: Text(
            "${weatherWithTimeList[0].main!.temp.toString()}° C",
            style: const TextStyle(
              color: Color.fromARGB(255, 84, 82, 82),
              fontSize: 12,
            ),
          ),
        ),
        subtitle: Text(
          date,
          style: const TextStyle(
            color: Color.fromARGB(255, 84, 82, 82),
            fontSize: 12,
          ),
        ),
        title: Row(
          children: [
            Text(
              weatherWithTimeList[0]
                      .weather![0]
                      .description!
                      .substring(0, 1)
                      .toUpperCase() +
                  weatherWithTimeList[0]
                      .weather![0]
                      .description!
                      .substring(1)
                      .toLowerCase(),
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                const Text("Wind",
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                Text(
                  "${weatherWithTimeList[0].wind!.speed.toString()} km/h",
                  style: const TextStyle(
                  fontSize: 14,
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Row(
              children: [
                const Text("Humidity", style:  TextStyle(
                  fontSize: 14,
                ),),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  "${weatherWithTimeList[0].main!.humidity!.toString()} %", style: const TextStyle(
                  fontSize: 14,
                ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 5),
            child: Row(
              children: [
                const Text("Visibility",
                  style:  TextStyle(
              fontSize: 14,
            ),
                ),
                const SizedBox(
                  width: 50,
                ),
                Text(
                  "${(weatherWithTimeList[0].visibility! / 1000).toString()} km", style: const TextStyle(
                  fontSize: 14,
                ),
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: weatherWithTimeList.length,
            itemBuilder: (context, index) {
              return Container(
                // color: Colors.white,
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                margin: const EdgeInsets.only(
                  top: 10.0,
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.white,
                      child: Lottie.asset(
                          "assets/animations/${getAnimation(weatherWithTimeList[index].weather![0].main!.toLowerCase(), weatherWithTimeList[index].weather![0].description!.toLowerCase())}"),
                    ),
                    const Spacer(),
                    Text(
                      weatherWithTimeList[index]
                              .weather![0]
                              .description!
                              .substring(0, 1)
                              .toUpperCase() +
                          weatherWithTimeList[index]
                              .weather![0]
                              .description!
                              .substring(1)
                              .toLowerCase(),
                    ),
                    const Spacer(),
                    Text(
                      DateFormat.jm().format(weatherWithTimeList[index].dtTxt!),
                    ),
                    const Spacer(),
                    Text(
                      "${weatherWithTimeList[index].main!.temp.toString()}° C",
                      style: const TextStyle(
                        color: Color.fromARGB(255, 84, 82, 82),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
