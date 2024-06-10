class Weather {
  final String country;
  final String condition;
  final String conditionIconUrl;
  final double windMph;
  final double windKph;
  final int windDegree;
  final String windDir;
  final int humidity;
  final double feelsLikeC;
  final double airQualityCo;
  final double airQualityNo2;

  Weather({
    required this.country,
    required this.condition,
    required this.conditionIconUrl,
    required this.windMph,
    required this.windKph,
    required this.windDegree,
    required this.windDir,
    required this.humidity,
    required this.feelsLikeC,
    required this.airQualityCo,
    required this.airQualityNo2,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      country: json['location']['country'],
      condition: json['current']['condition']['text'],
      conditionIconUrl: 'https:${json['current']['condition']['icon']}',
      windMph: json['current']['wind_mph'],
      windKph: json['current']['wind_kph'],
      windDegree: json['current']['wind_degree'],
      windDir: json['current']['wind_dir'],
      humidity: json['current']['humidity'],
      feelsLikeC: json['current']['feelslike_c'],
      airQualityCo: json['current']['air_quality']['co'],
      airQualityNo2: json['current']['air_quality']['no2'],
    );
  }
}
