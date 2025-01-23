import 'package:route_planner/models/location.dart';

class LocationMock extends Location {
  LocationMock({required super.latitude, required super.longitude});

  factory LocationMock.$default() {
    return LocationMock(
      latitude: 5,
      longitude: 5,
    );
  }
}
