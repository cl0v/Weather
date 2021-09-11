import 'dart:convert';

class CityInfo {
  String name;
  String country;
  double temperature;

  CityInfo({
    required this.country,
    required this.name,
    required this.temperature,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'temperature': temperature,
    };
  }

  factory CityInfo.fromMap(Map<String, dynamic> map) {
    return CityInfo(
      name: map['name'],
      country: map['sys']['country'],
      temperature: map['main']['temp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CityInfo.fromJson(String source) => CityInfo.fromMap(json.decode(source));
}

