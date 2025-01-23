import 'package:route_planner/enums/side.dart';

enum Direction {
  unknown('unknown', Side.unknown),
  start('start', Side.start),
  turnSlightLeft('turn-slight-left', Side.left),
  turnSharpLeft('turn-sharp-left', Side.left),
  turnLeft('turn-left', Side.left),
  turnSlightRight('turn-slight-right', Side.right),
  turnSharpRight('turn-sharp-right', Side.right),
  keepRight('keep-right', Side.right),
  keepLeft('keep-left', Side.left),
  uturnLeft('uturn-left', Side.left),
  uturnRight('uturn-right', Side.right),
  turnRight('turn-right', Side.right),
  straight('straight', Side.straight),
  rampLeft('ramp-left', Side.left),
  rampRight('ramp-right', Side.right),
  merge('merge', Side.straight),
  forkLeft('fork-left', Side.left),
  forkRight('fork-right', Side.right),
  ferry('ferry', Side.straight),
  ferryTrain('ferry-train', Side.straight),
  roundaboutLeft('roundabout-left', Side.left),
  roundaboutRight('roundabout-right', Side.right);

  final String value;
  final Side category;

  const Direction(this.value, this.category);

  factory Direction.fromString(String directionStr) {
    if (directionStr.isEmpty) {
      return Direction.unknown;
    }

    for (var direction in Direction.values) {
      if (directionStr == direction.value) {
        return direction;
      }
    }

    throw Exception('Unknown direction value: $directionStr');
  }
}
