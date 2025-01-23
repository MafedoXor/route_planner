class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['lat'],
      longitude: json['lng'],
    );
  }

  @override
  String toString() {
    return 'lat: $latitude, lng: $longitude}';
  }
}
