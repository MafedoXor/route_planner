import 'package:route_planner/models/route_step_model.dart';

class RouteModel {
  final int duration;
  final int distance;
  final List<RouteStep> steps;

  RouteModel({
    required this.duration,
    required this.distance,
    required this.steps,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) {
    return RouteModel(
      duration: json['duration'],
      distance: json['distance'],
      steps: (json['steps'] as List).map((e) => RouteStep.fromJson(e)).toList(),
    );
  }
}
