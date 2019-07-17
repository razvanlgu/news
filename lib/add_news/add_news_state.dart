import 'package:meta/meta.dart';

class AddNewsState {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final String content;

  AddNewsState({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.content
  });

  factory AddNewsState.initial() =>
    AddNewsState(
      id: '',
      title: '',
      summary: '',
      imageUrl: '',
      content: ''
    );

  AddNewsState copyWith({
    String id,
    String title,
    String summary,
    String imageUrl,
    String content
  }) =>
      AddNewsState(
        id: id ?? this.id,
        title: title ?? this.title,
        summary: summary ?? this.summary,
        imageUrl: imageUrl ?? this.imageUrl,
        content: content ?? this.content
      );
}