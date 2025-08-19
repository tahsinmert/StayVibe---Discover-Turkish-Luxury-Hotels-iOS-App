import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';
import '../model/weather_model.dart';

class WeatherService {
  static const String _apiKey = '73db77652e9351f4efeb699fb24be9ea';
  static const String _baseUrl = 'https://api.openweathermap.org/data/2.5/weather';

  // Cache for weather data to avoid repeated API calls
  static final Map<String, WeatherModel> _weatherCache = {};
  static final Map<String, DateTime> _cacheTimestamps = {};
  static const Duration _cacheDuration = Duration(minutes: 30);

  static Future<WeatherModel?> getWeatherForCity(String cityName) async {
    try {
      // Check cache first
      if (_weatherCache.containsKey(cityName)) {
        final timestamp = _cacheTimestamps[cityName];
        if (timestamp != null && 
            DateTime.now().difference(timestamp) < _cacheDuration) {
          return _weatherCache[cityName];
        }
      }

      // Get coordinates for the city
      final coordinates = await _getCityCoordinates(cityName);
      if (coordinates == null) return null;

      // Fetch weather data
      final response = await http.get(
        Uri.parse(
          '$_baseUrl?lat=${coordinates.latitude}&lon=${coordinates.longitude}&appid=$_apiKey&units=metric&lang=tr'
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final weather = WeatherModel.fromJson(data);
        
        // Cache the result
        _weatherCache[cityName] = weather;
        _cacheTimestamps[cityName] = DateTime.now();
        
        return weather;
      } else {
        print('Weather API Error: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Weather Service Error: $e');
      return null;
    }
  }

  static Future<Location?> _getCityCoordinates(String cityName) async {
    try {
      // Turkish city mappings for better accuracy
      final cityMappings = {
        'İstanbul': 'Istanbul',
        'Antalya': 'Antalya',
        'Bodrum': 'Bodrum',
        'Kapadokya': 'Goreme', // Göreme is the main town in Cappadocia
        'Fethiye': 'Fethiye',
        'Alanya': 'Alanya',
        'Çeşme': 'Cesme',
      };

      final searchName = cityMappings[cityName] ?? cityName;
      final locations = await locationFromAddress('$searchName, Turkey');
      
      if (locations.isNotEmpty) {
        return locations.first;
      }
      
      return null;
    } catch (e) {
      print('Geocoding Error: $e');
      return null;
    }
  }

  static void clearCache() {
    _weatherCache.clear();
    _cacheTimestamps.clear();
  }

  static String getWeatherEmoji(String weatherDescription) {
    final description = weatherDescription.toLowerCase();
    
    if (description.contains('clear')) return '☀️';
    if (description.contains('cloud')) return '☁️';
    if (description.contains('rain')) return '🌧️';
    if (description.contains('snow')) return '❄️';
    if (description.contains('thunder')) return '⛈️';
    if (description.contains('fog') || description.contains('mist')) return '🌫️';
    if (description.contains('drizzle')) return '🌦️';
    if (description.contains('shower')) return '🌦️';
    
    return '🌤️'; // Default
  }
}
