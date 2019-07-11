import 'package:meta/meta.dart';
import 'package:news/entities/news_item.dart';

@immutable
class HomeState {
  final List<NewsItem> news;

  // Constrctor
  HomeState({
    this.news,
  });

  factory HomeState.initial() =>
      HomeState(
        news: List.unmodifiable(<NewsItem>[]),
      );

  HomeState copyWith({
    List<NewsItem> news
  }) =>
    HomeState(
      news: news ?? this.news
    );
}