@immutable
class HomeState {
  final String mesaj;

  // Constrctor
  HomeState({
    this.mesaj;
  });

  factory HomeState.initial() =>
      HomeState(
        mesaj: 'Acesta e un mesaj default :(',
      );

  HomeState copyWith({
    String mesaj
  }) =>
    HomeState(
    mesaj: mesaj ?? this.mesaj,
  );
}