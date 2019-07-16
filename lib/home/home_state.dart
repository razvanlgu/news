import 'package:meta/meta.dart';

@immutable
class HomeState {

  final List<String> idNews;

  // Constrctor
  HomeState({
    this.idNews,
  });

  factory HomeState.initial() =>
      HomeState(
        idNews: List.unmodifiable(<String>[]),
      );

  HomeState copyWith({
    List<String> idNews,
  }) =>
    HomeState(
      idNews: idNews ?? this.idNews,
    );

}