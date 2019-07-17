import 'dart:io';

import 'package:meta/meta.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'add_news_actions.dart';

class AddNewsViewModel {
  final String title;
  final String summary;
  final String imageUrl;
  final String content;

  final Function({String title, String summary,
      String imageUrl, String content}) updateAddedNews;
  final Function() addNewsToFirebase;
  final Function(File image) uploadPhoto;

  // Constructor
  AddNewsViewModel({
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.content,
    @required this.updateAddedNews,
    @required this.addNewsToFirebase,
    this.uploadPhoto,
  });

  factory AddNewsViewModel.fromStore(Store<AppState> store) {
    return AddNewsViewModel(
      title: store.state.addNewsState.title,
      summary: store.state.addNewsState.summary,
      imageUrl: store.state.addNewsState.imageUrl,
      content: store.state.addNewsState.content,
      updateAddedNews: ({String title, String summary,
          String imageUrl, String content}) =>
        store.dispatch(UpdateAddedNewsAction(
            imageUrl: imageUrl,
            title: title,
            summary: summary,
            content: content)),
      addNewsToFirebase: () => store.dispatch(AddNewsToFirebaseAction()),
      uploadPhoto: (File image) => store.dispatch(UploadPhoto(img: image)),
    );
  }
}