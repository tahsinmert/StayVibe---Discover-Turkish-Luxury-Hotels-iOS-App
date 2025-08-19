class WeatherModel {
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final String cityName;
  final int pressure;
  final double feelsLike;

  WeatherModel({
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.cityName,
    required this.pressure,
    required this.feelsLike,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble(),
      description: json['weather'][0]['description'] ?? '',
      icon: json['weather'][0]['icon'] ?? '',
      humidity: json['main']['humidity'] ?? 0,
      windSpeed: (json['wind']['speed'] as num).toDouble(),
      cityName: json['name'] ?? '',
      pressure: json['main']['pressure'] ?? 0,
      feelsLike: (json['main']['feels_like'] as num).toDouble(),
    );
  }

  String get temperatureFormatted => '${temperature.round()}°C';
  String get feelsLikeFormatted => '${feelsLike.round()}°C';
  String get windSpeedFormatted => '${windSpeed.toStringAsFixed(1)} m/s';
  
  String get weatherIconUrl => 'https://openweathermap.org/img/wn/$icon@2x.png';
  
  String get descriptionCapitalized => 
      description.split(' ').map((word) => 
          word[0].toUpperCase() + word.substring(1)
      ).join(' ');
}
