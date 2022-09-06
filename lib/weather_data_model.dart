import 'dart:convert';

WeatherData welcomeFromJson(String str) =>
    WeatherData.fromJson(json.decode(str));

String welcomeToJson(WeatherData data) => json.encode(data.toJson());

class WeatherData {
  WeatherData({
    required this.weather, // -> des, icon
    required this.main, //-> temp
    required this.sys, //-> country
    required this.name, //-> city
  });

  List<Weather> weather;
  Main main;
  Sys sys;
  String name;

  factory WeatherData.fromJson(Map<String, dynamic> json) => WeatherData(
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
        main: Main.fromJson(json["main"]),
        sys: Sys.fromJson(json["sys"]),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "weather": List<dynamic>.from(weather.map((x) => x.toJson())),
        "main": main.toJson(),
        "sys": sys.toJson(),
        "name": name,
      };
}

class Main {
  Main({
    required this.temp,
  });

  double temp;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
      };
}

class Sys {
  Sys({
    required this.country,
  });

  String country;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

class Weather {
  Weather({
    required this.description,
    required this.icon,
  });
  String description;
  String icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "description": description,
        "icon": icon,
      };
}
