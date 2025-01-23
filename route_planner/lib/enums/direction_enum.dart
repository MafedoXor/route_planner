enum Direction {
  unknown('unknown'),
  start('start'),
  turnSlightLeft('turn-slight-left'),
  turnSharpLeft('turn-sharp-left'),
  turnLeft('turn-left'),
  turnSlightRight('turn-slight-right'),
  turnSharpRight('turn-sharp-right'),
  keepRight('keep-right'),
  keepLeft('keep-left'),
  uturnLeft('uturn-left'),
  uturnRight('uturn-right'),
  turnRight('turn-right'),
  straight('straight'),
  rampLeft('ramp-left'),
  rampRight('ramp-right'),
  merge('merge'),
  forkLeft('fork-left'),
  forkRight('fork-right'),
  ferry('ferry'),
  ferryTrain('ferry-train'),
  roundaboutLeft('roundabout-left'),
  roundaboutRight('roundabout-right');

  final String value;

  const Direction(this.value);

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
