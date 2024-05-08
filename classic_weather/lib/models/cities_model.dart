class CityAutocompleteModel {
  String type;
  List<Feature>? features;
  Query? query;

  CityAutocompleteModel({
    required this.type,
    required this.features,
    required this.query,
  });

  factory CityAutocompleteModel.fromJson(Map<String, dynamic> json) =>
      CityAutocompleteModel(
        type: json["type"] ?? "",
        features: json["features"] != null
            ? List<Feature>.from(
                json["features"].map((x) => Feature.fromJson(x)))
            : null,
        query: json["query"] != null ? Query.fromJson(json["query"]) : null,
      );
}

class Feature {
  String type;
  Properties properties;

  Feature({
    required this.type,
    required this.properties,
  });

  factory Feature.fromJson(Map<String, dynamic> json) => Feature(
        type: json["type"],
        properties: Properties.fromJson(json["properties"]),
      );
}

class Properties {
  String? country;
  String? countryCode;
  String? state;
  String? county;
  String? city;
  String? postcode;
  String? stateCode;
  double? lon;
  double? lat;
  int? population;
  String? formatted;
  String? addressLine1;
  String? addressLine2;
  String? category;
  String? hamlet;
  String? name;

  Properties({
    required this.country,
    required this.countryCode,
    required this.state,
    this.county,
    required this.city,
    this.postcode,
    required this.stateCode,
    required this.lon,
    required this.lat,
    this.population,
    required this.formatted,
    required this.addressLine1,
    required this.addressLine2,
    required this.category,
    this.hamlet,
    this.name,
  });

  factory Properties.fromJson(Map<String, dynamic> json) => Properties(
        country: json["country"] ?? "",
        countryCode: json["country_code"] ?? "",
        state: json["state"] ?? "",
        county: json["county"] ?? "",
        city: json["city"] ?? "",
        postcode: json["postcode"] ?? "",
        stateCode: json["state_code"] ?? "",
        lon: json["lon"]?.toDouble(),
        lat: json["lat"]?.toDouble(),
        population: json["population"] != null ? 0 : json["population"],
        formatted: json["formatted"] ?? "",
        addressLine1: json["address_line1"] ?? "",
        addressLine2: json["address_line2"] ?? "",
        category: json["category"] ?? "",
        hamlet: json["hamlet"] ?? "",
        name: json["name"] ?? "",
      );
}

class Query {
  String? text;

  Query({
    required this.text,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        text: json["text"] ?? "",
      );
}
