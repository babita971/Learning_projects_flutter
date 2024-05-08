class WeatherModel {
  WeatherModel({
    this.city,
    this.temperature,
    this.mainTitle,
    this.mainDescription,
  });
  final String? city;
  final double? temperature;
  final String? mainTitle;
  final String? mainDescription;

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      city: json['name'],
      temperature: json['main']['temp'].toDouble(),
      mainTitle: json['weather'][0]['main'],
      mainDescription: json['weather'][0]['description'].toString(),
    );
  }
}
