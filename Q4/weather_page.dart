import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart'; // Add this import

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _locationController = TextEditingController();
  WeatherService _weatherService = WeatherService();
  Weather? _weather;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                hintText: 'Enter location/address',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                Weather? weather = await _weatherService.getWeather(_locationController.text);
                setState(() {
                  _weather = weather;
                });
              },
              child: Text('Get Weather'),
            ),
            SizedBox(height: 20),
            _weather != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Country: ${_weather!.country}'),
                      Text('Condition: ${_weather!.condition}'),
                      Image.network(_weather!.conditionIconUrl),
                      Text('Wind MPH: ${_weather!.windMph}'),
                      Text('Wind KPH: ${_weather!.windKph}'),
                      Text('Wind Degree: ${_weather!.windDegree}'),
                      Text('Wind Direction: ${_weather!.windDir}'),
                      Text('Humidity: ${_weather!.humidity}%'),
                      Text('Feels Like: ${_weather!.feelsLikeC}°C'),
                      Text('Air Quality - CO: ${_weather!.airQualityCo}'),
                      Text('Air Quality - NO2: ${_weather!.airQualityNo2}'),
                    ],
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
