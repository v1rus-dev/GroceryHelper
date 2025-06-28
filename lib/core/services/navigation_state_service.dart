class NavigationStateService {
  static final NavigationStateService _instance = NavigationStateService._internal();
  factory NavigationStateService() => _instance;
  NavigationStateService._internal();

  static NavigationStateService get instance => _instance;

  int _lastKnownIndex = 0;

  int get lastKnownIndex => _lastKnownIndex;

  void setLastKnownIndex(int index) {
    _lastKnownIndex = index;
  }

  void clearLastKnownIndex() {
    _lastKnownIndex = 0;
  }
}
