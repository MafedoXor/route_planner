import 'package:route_planner/enums/direction_enum.dart';
import 'package:route_planner/models/route_step_model.dart';

import 'location_mock.dart';

class RouteStepMock extends RouteStep {
  RouteStepMock({required super.direction, required super.location});

  factory RouteStepMock.$default() {
    return RouteStepMock(
      direction: Direction.start,
      location: LocationMock.$default(),
    );
  }
}
