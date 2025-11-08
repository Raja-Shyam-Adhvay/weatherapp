import 'package:flutter/material.dart';
// Removed geolocator import
import 'package:clima/screens/location_screen.dart';
import 'package:clima/services/weather.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  WeatherModel weatherModel = WeatherModel();

  @override
  void initState() {
    super.initState();
    // Renamed function to reflect its new, simplified purpose
    getHardcodedWeatherData();
  }

  // NOTE: This function now bypasses all GPS/permission checks.
  Future<void> getHardcodedWeatherData() async {
    // Hardcoded coordinates (e.g., London, UK)
    double latitude = 51.5074;
    double longitude = 0.1278;

    try {
      // 1. Skip all Geolocator calls
      // 2. Directly call the weather API with the hardcoded coordinates
      var weatherData = await weatherModel.getLocationWeather(
        latitude: latitude,
        longitude: longitude,
      );

      if (weatherData != null) {
        // Navigate to LocationScreen with the fetched data
        // Use pushReplacement to clear the loading screen from the stack
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return LocationScreen(locationWeather: weatherData);
        }));
      } else {
        _showErrorAndNavigate('Could not fetch weather data. Check API key/Internet.');
      }
    } catch (e) {
      // Catch any HTTP or JSON decoding errors
      _showErrorAndNavigate('Critical Error fetching data: ${e.toString()}');
    }
  }

  void _showErrorAndNavigate(String errorMessage) {
    print(errorMessage);
    // Ensure we are mounted before navigating
    if (mounted) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LocationScreen(
            locationWeather: {'error': errorMessage});
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ), // Show a loading indicator
      ),
    );
  }
}