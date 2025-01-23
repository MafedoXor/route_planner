// import 'dart:math';

// import 'package:route_planner/screens/plan_route/models/location.dart';

// example utility class to normalize the route
// class NormalizeRoute {
//   static String normalize(Location location1, Location location2) {
//     const double R = 6371; // Earth's radius in km
//
//     // Convert degrees to radians
//     double toRadians(double degree) => degree * pi / 180;
//
//     double lat1Rad = toRadians(location1.latitude);
//     double lat2Rad = toRadians(location2.latitude);
//     double deltaLat = toRadians(location2.latitude - location1.latitude);
//     double deltaLon = toRadians(location2.longitude - location2.longitude);
//
//     // Haversine formula
//     double a = sin(deltaLat / 2) * sin(deltaLat / 2) +
//         cos(lat1Rad) * cos(lat2Rad) * sin(deltaLon / 2) * sin(deltaLon / 2);
//
//     double c = 2 * atan2(sqrt(a), sqrt(1 - a));
//
//     // Distance in kilometers
//     return (R * c).toString();
//   }
// }
