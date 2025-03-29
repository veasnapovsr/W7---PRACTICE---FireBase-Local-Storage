import '../../../model/ride/ride_pref.dart';
import '../ride_preferences_repository.dart';

import '../../../dummy_data/dummy_data.dart';

class MockRidePreferencesRepository extends RidePreferencesRepository {
  final List<RidePreference> _pastPreferences = fakeRidePrefs;

  @override
  Future<void> addPreference(RidePreference preference) async {
    Future.delayed(
        Duration(seconds: 0), () => _pastPreferences.add(preference));
  }

  @override
  Future<List<RidePreference>> getPastPreferences() {
    return Future.delayed(Duration(seconds: 2), () => _pastPreferences);
  }

  // @override
  // List<RidePreference> getPastPreferences() {
  //   return _pastPreferences;
  // }

  // @override
  // void addPreference(RidePreference preference) {
  //   _pastPreferences.add(preference);
  // }
}
