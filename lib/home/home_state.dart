import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';

@immutable
class HomeState {

  final List<NewsItem> news;
  final double expandHeight;

  // Constrctor
  HomeState({
    this.news,
    this.expandHeight,
  });

  factory HomeState.initial() =>
      HomeState(
        news: List.unmodifiable(<NewsItem>[]),
        expandHeight: 0.0,
      );


  HomeState copyWith({
    List<NewsItem> news,
    double expandHeight,
  }) =>
    HomeState(
      news: news ?? this.news,
      expandHeight: expandHeight ?? this.expandHeight,
    );

}