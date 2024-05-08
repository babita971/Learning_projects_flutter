import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sarcastic_weather/controller/home_controller.dart';
import 'package:sarcastic_weather/models/response_model.dart';
import 'package:sarcastic_weather/services/api_service.dart';

class CitySearchDelegate extends SearchDelegate {
  final apiService = ApiService();
  var listOfCities = [];
  final controller = Get.find<HomeController>();
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          listOfCities.clear();
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<ResponseModel>(
        future: apiService.getCitySuggestions(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.error != null) {
            print("Error");
            return const Center(
              child: Text(
                "Oops. We've encountered an error'.",
                style: TextStyle(fontSize: 18),
              ),
            );
          } else if (snapshot.hasData) {
            listOfCities = snapshot.data!.data!.features ?? [];
            return listOfCities.isEmpty
                ? const Center(
                    child: Text(
                      "Oops. We cannot find what you're looking for.",
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                : ListView.builder(
                    itemCount: listOfCities.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () async {
                          controller.latitude.value =
                              listOfCities[index].properties.lat;
                          controller.longitude.value =
                              listOfCities[index].properties.lon;
                          try {
                            await controller.getSearchWeatherInformation();
                            close(context, null);
                          } catch (e) {
                            if (controller.isErrorOccurred.value) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const SizedBox(),
                                      content: const Text(
                                          "Oops. City's weather data not found."),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Okay"),
                                        ),
                                      ],
                                    );
                                  });
                            }
                          }
                        },
                        child: ListTile(
                          title: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    listOfCities[index].properties.city,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    listOfCities[index].properties.country,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }
          return const SizedBox();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return listOfCities.isEmpty
        ? const ListTile(
            title: Text(
              "Please enter your city",
              style: TextStyle(fontSize: 18),
            ),
          )
        : ListView.builder(
            itemCount: listOfCities.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Row(
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listOfCities[index].properties.city,
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            listOfCities[index].properties.country,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            ),
                          ),
                        ])
                  ],
                ),
              );
            },
          );
  }
}
