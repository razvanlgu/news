/****
    De importat toate stateurile
 ****/

import 'package:meta/meta.dart';

@immutable
class AppState {
  // De declarat toate stateurile

  // Constructor
  AppState({
    // this.numeState
  });

  factory AppState.initial() {
    return AppState(
      // numeState: NumeState.initial(),
    );
  }
}