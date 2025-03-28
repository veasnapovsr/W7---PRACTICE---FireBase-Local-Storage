import 'package:flutter/foundation.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  final RidePreferencesRepository _repository;

  RidePreference? _currentPreference;
  List<RidePreference> _preferencesHistory = [];

  RidesPreferencesProvider(this._repository) {
    _preferencesHistory = _repository.getPastPreferences();
  }

  RidePreference? get currentPreference => _currentPreference;

  List<RidePreference> get preferencesHistory => _preferencesHistory;

  void setCurrentPreference(RidePreference newPreference) {
    if (_currentPreference == null ||
        !_currentPreference!.equals(newPreference)) {
      _currentPreference = newPreference;

      if (!_preferencesHistory.contains(newPreference)) {
        _preferencesHistory.insert(0, newPreference);
      }

      notifyListeners();
    }
  }
}
