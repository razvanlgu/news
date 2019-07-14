import 'package:meta/meta.dart';

@immutable
class PageState {

  final String title;
  final String imageUrl;
  final String content;
  final int likes;
  final int dislikes;

  // Constrctor
  PageState({
    this.title,
    this.imageUrl,
    this.content,
    this.likes,
    this.dislikes,
  });

  factory PageState.initial() =>
      PageState(
        title: '',
        imageUrl: '',
        content: '',
        likes: 0,
        dislikes: 0,
      );


  PageState copyWith({
    String title,
    String imageUrl,
    String content,
    int likes,
    int dislikes,
  }) =>
      PageState(
        title: title ?? this.title,
        imageUrl: imageUrl ?? this.imageUrl,
        content: content ?? this.content,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
      );

}