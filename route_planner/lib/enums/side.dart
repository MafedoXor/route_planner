import 'package:route_planner/enums/direction_enum.dart';

enum Side {
  unknown,
  start,
  left,
  right,
  straight;

  factory Side.fromDirection(Direction direction) {
    switch (direction) {
      case Direction.turnSlightLeft:
      case Direction.turnSharpLeft:
      case Direction.turnLeft:
      case Direction.keepLeft:
      case Direction.uturnLeft:
      case Direction.rampLeft:
      case Direction.forkLeft:
      case Direction.roundaboutLeft:
        return Side.left;
      case Direction.turnSlightRight:
      case Direction.turnSharpRight:
      case Direction.turnRight:
      case Direction.keepRight:
      case Direction.uturnRight:
      case Direction.rampRight:
      case Direction.forkRight:
      case Direction.roundaboutRight:
        return Side.right;
      case Direction.straight:
        return Side.straight;
      case Direction.start:
        return Side.start;
      default:
        return Side.unknown;
    }
  }
}
