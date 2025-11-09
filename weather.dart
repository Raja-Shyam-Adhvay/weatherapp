import 'package:http/http.dart' as http;
import 'dart:convert';

// The actual API Key is here.
const String apiKey = 'd60071b5aa3aee7e325a55ef25d0b5cb';
const String openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
   
    Uri url = Uri.parse(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric'
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('City weather request failed with status code: ${response.statusCode}');
      return {'error': 'City weather API failed (Code: ${response.statusCode}).'};
    }
  }

  Future<dynamic> getLocationWeather({required double latitude, required double longitude}) async {

    Uri url = Uri.parse(
        '$openWeatherMapURL?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric'
    );
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else {
      print('Location weather request failed with status code: ${response.statusCode}');
      return {'error': 'Location weather API failed (Code: ${response.statusCode}).'};
    }
  }

  // Helper functions for weather icon and message based on OpenWeatherMap IDs
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

}
