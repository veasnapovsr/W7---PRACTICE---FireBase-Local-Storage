import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/ui/providers/async_value.dart';

class RidesPrefProvider extends ChangeNotifier {
  final RidePreferencesRepository repository;
  // current pref
  RidePreference? _currentPref;
  // past pref
  late AsyncValue<List<RidePreference>> pastPreferences;
  // constructor
  RidesPrefProvider({required this.repository}) {
    pastPreferences = AsyncValue.loading();
    fetchPastPreference();
  }

  RidePreference? get currentPref {
    return _currentPref;
  }

  Future<void> setCurrentPreference(RidePreference ridePref) async {
    if (_currentPref == ridePref) {
      return;
    }
    _currentPref = ridePref;
    // add only the ride pref that doesn't exist in repo
    final preferences = await repository.getPastPreferences();
    if (!preferences.contains(ridePref)) {
      await repository.addPreference(ridePref);
      await fetchPastPreference();
    }
    notifyListeners();
  }

  Future<void> fetchPastPreference() async {
    // pastPreferences = AsyncValue.loading();
    // notifyListeners();

    try {
      pastPreferences = AsyncValue.success(await preferenceHistory());
    } catch (error) {
      pastPreferences = AsyncValue.error(error);
    }
    notifyListeners();
  }

  Future<List<RidePreference>> preferenceHistory() async {
    final pastPref = await repository.getPastPreferences();
    return pastPref.reversed.toList();
  }
}
