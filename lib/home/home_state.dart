import 'package:meta/meta.dart';

class Item{
  final int id;
  final String continut;

  Item({
    @required this.id,
    @required this.continut
  });

  Item copyWith({int id, String continut}) {
    return Item(
        id: id ?? this.id,
        continut: continut ?? this.continut
    );
  }
}

@immutable
class HomeState {
  final List<Item> news;
  final String mesaj;

  // Constrctor
  HomeState({
    this.news,
    this.mesaj
  });

  factory HomeState.initial() =>
      HomeState(
        news: List.unmodifiable(<Item>[]),
        mesaj: 'Acesta e un mesaj default :(',
      );

  HomeState copyWith({
    List<Item> news,
    String mesaj
  }) =>
    HomeState(
      news: news ?? this.news,
      mesaj: mesaj ?? this.mesaj,
    );
}