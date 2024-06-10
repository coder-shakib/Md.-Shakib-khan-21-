import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  final String apiKey = '8f24904629c24131a3643933240706';

  Future<Weather?> getWeather(String location) async {
    final url =
        'http://api.weatherapi.com/v1/current.json?key=$apiKey&q=$location&aqi=yes';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Weather.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching weather: $e');
      return null;
    }
  }
}
