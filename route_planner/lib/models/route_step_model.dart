import 'package:route_planner/enums/direction_enum.dart';
import 'package:route_planner/models/location.dart';

class RouteStep {
  final Direction? direction;
  final Location location;

  RouteStep({
    required this.direction,
    required this.location,
  });

  factory RouteStep.fromJson(Map<String, dynamic> json) {
    return RouteStep(
      direction: Direction.fromString(json['direction'] ?? ''),
      location: Location.fromJson(json['location']),
    );
  }
}
