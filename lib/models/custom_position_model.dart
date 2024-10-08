class CustomPosition {
  final double longitude;
  final double latitude;
  final DateTime timestamp;
  final double accuracy;
  final double altitude;
  final double altitudeAccuracy;
  final double heading;
  final double headingAccuracy;
  final double speed;
  final double speedAccuracy;

  CustomPosition({
    required this.longitude,
    required this.latitude,
    required this.timestamp,
    required this.accuracy,
    required this.altitude,
    required this.altitudeAccuracy,
    required this.heading,
    required this.headingAccuracy,
    required this.speed,
    required this.speedAccuracy,
  });

  // Factory method for JSON serialization/deserialization
  factory CustomPosition.fromJson(Map<String, dynamic> json) {
    return CustomPosition(
      longitude: json['longitude'].toDouble(),
      latitude: json['latitude'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
      accuracy: json['accuracy'].toDouble(),
      altitude: json['altitude'].toDouble(),
      altitudeAccuracy: json['altitudeAccuracy'].toDouble(),
      heading: json['heading'].toDouble(),
      headingAccuracy: json['headingAccuracy'].toDouble(),
      speed: json['speed'].toDouble(),
      speedAccuracy: json['speedAccuracy'].toDouble(),
    );
  }

  // Convert to JSON format
  Map<String, dynamic> toJson() {
    return {
      'longitude': longitude,
      'latitude': latitude,
      'timestamp': timestamp.toIso8601String(),
      'accuracy': accuracy,
      'altitude': altitude,
      'altitudeAccuracy': altitudeAccuracy,
      'heading': heading,
      'headingAccuracy': headingAccuracy,
      'speed': speed,
      'speedAccuracy': speedAccuracy,
    };
  }
}
