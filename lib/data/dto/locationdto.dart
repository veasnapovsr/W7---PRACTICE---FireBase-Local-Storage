import 'package:week_3_blabla_project/model/location/locations.dart';

//Given sample code
/// class is for converting a Location model from JSON.
class LocationDto {
  static Map<String, dynamic> toJson(Location model) => {
        'name': model.name,
        'country': model.country.name,
      };

  static Location fromJson(Map<String, dynamic> json) => Location(
        name: json['name'],
        country: _parseCountry(json['country']),
      );

  static Country _parseCountry(String value) => Country.values.firstWhere(
        (e) => e.name == value,
        orElse: () => throw ArgumentError('Invalid country: $value'),
      );
}
