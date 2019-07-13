import 'package:meta/meta.dart';

class NewsItem {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final double expandHeight;

  NewsItem({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.likes,
    @required this.dislikes,
    @required this.expandHeight,
  });

  NewsItem copyWith({
    String id,
    String title,
    String summary,
    String imageUrl,
    int likes,
    int dislikes,
    double expandHeight
    }) {
    return NewsItem(
        id: id ?? this.id,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        imageUrl: imageUrl ?? this.imageUrl,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        expandHeight: expandHeight ?? this.expandHeight,
    );
  }

}