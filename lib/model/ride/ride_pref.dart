import '../location/locations.dart';

///
/// This model describes a ride preference.
/// A ride preference consists of the selection of a departure + arrival + a date and a number of passenger
///
// class RidePreference {
//   final Location departure;
//   final DateTime departureDate;
//   final Location arrival;
//   final int requestedSeats;
//
//   const RidePreference(
//       {required this.departure,
//       required this.departureDate,
//       required this.arrival,
//       required this.requestedSeats});
//
//   @override
//   String toString() {
//     return 'RidePref(departure: ${departure.name}, '
//         'departureDate: ${departureDate.toIso8601String()}, '
//         'arrival: ${arrival.name}, '
//         'requestedSeats: $requestedSeats)';
//   }
// }
import 'package:week_3_blabla_project/model/location/locations.dart';

class RidePreference {
  final Location departure;
  final DateTime departureDate;
  final Location arrival;
  final int requestedSeats;

  RidePreference({
    required this.departure,
    required this.departureDate,
    required this.arrival,
    required this.requestedSeats,
  });

  // Implement == operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RidePreference &&
        departure == other.departure &&
        departureDate == other.departureDate &&
        arrival == other.arrival &&
        requestedSeats == other.requestedSeats;
  }

  // Implement hashCode
  @override
  int get hashCode {
    return departure.hashCode ^
    departureDate.hashCode ^
    arrival.hashCode ^
    requestedSeats.hashCode;
  }

  // Additional method for comparison (as suggested in the document)
  bool equals(RidePreference other) {
    return this == other;
  }
}