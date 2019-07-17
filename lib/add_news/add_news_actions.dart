import 'dart:io';

class UpdateAddedNewsAction{
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final String content;

  UpdateAddedNewsAction({
    this.id,
    this.title,
    this.summary,
    this.imageUrl,
    this.content
  });
}

class AddNewsToFirebaseAction{
  final String imageUrl;

  AddNewsToFirebaseAction({this.imageUrl});
}

class UploadPhoto{
  final File img;

  UploadPhoto({this.img});
}
