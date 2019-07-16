import 'package:meta/meta.dart';

@immutable
class NewsCardState {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final double expandHeight;
  final bool isFav;
  final bool isLiked;

  NewsCardState({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.likes,
    @required this.dislikes,
    @required this.expandHeight,
    @required this.isFav,
    @required this.isLiked,
  });

  factory NewsCardState.initial() =>
      NewsCardState(
    id: '',
    title: '',
    summary: '',
    imageUrl: '',
    likes: 0,
    dislikes: 0,
    expandHeight: 0,
    isFav: false,
    isLiked: null,
  );

  NewsCardState copyWith({
    String id,
    String title,
    String summary,
    String imageUrl,
    int likes,
    int dislikes,
    double expandHeight,
    bool isFav,
    bool isLiked,
  }) {
    return NewsCardState(
      id: id ?? this.id,
      title: title ?? this.title,
      summary: summary ?? this.summary,
      imageUrl: imageUrl ?? this.imageUrl,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
      expandHeight: expandHeight ?? this.expandHeight,
      isFav: isFav ?? this.isFav,
      isLiked: isLiked ?? this.isLiked,
    );
  }

}