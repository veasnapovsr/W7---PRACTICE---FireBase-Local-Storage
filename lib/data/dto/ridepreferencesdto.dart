import 'package:week_3_blabla_project/data/dto/location_dto.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class RidePreferencesDto {
  static Map<String, dynamic> toJson(RidePreference model) {
    return {
      'departure': LocationDto.toJson(model.departure),
      'departureDate': model.departureDate.toIso8601String(),
      'arrival': LocationDto.toJson(model.arrival),
      'seats': model.requestedSeats,
    };
  }

  static RidePreference fromJson(Map<String, dynamic> json) {
    return RidePreference(
      departure: LocationDto.fromJson(json['departure']),
      departureDate: DateTime.parse(json['departureDate']),
      arrival: LocationDto.fromJson(json['arrival']),
      requestedSeats: json['seats'],
    );
  }
}
