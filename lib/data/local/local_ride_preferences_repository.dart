import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/dto/ride_preferences_dto.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/dummy_data/dummy_data.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = "ride_preferences";

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();
    // Get the current list of preferences
    List<RidePreference> currentPreferences = await getPastPreferences();
    // Add the new preference
    currentPreferences.add(preference);

    await prefs.setStringList(
      _preferencesKey,
      currentPreferences
          .map((pref) => jsonEncode(RidePreferencesDto.toJson(pref)))
          .toList(),
    );
  }

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    // Get SharedPreferences instance
    final prefs = await SharedPreferences.getInstance();

    // Get the string list from the key
    final prefsList = prefs.getStringList(_preferencesKey) ?? [];
    return prefsList
        .map((json) => RidePreferencesDto.fromJson(jsonDecode(json)))
        .toList();
  }
}
