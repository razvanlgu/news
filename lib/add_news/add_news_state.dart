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
      imageUrl: 'https://firebasestorage.googleapis.com/v0/b/news-868b9.appspot.com/o/News%2Fboxer.jpg?alt=media&token=56632a12-a7a2-4c2b-ae47-e8aa4b8fd89f',
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