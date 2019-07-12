import 'package:meta/meta.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

import 'add_news_actions.dart';

class AddNewsViewModel {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final String content;

  final Function(String id, String title, String summary,
      String imageUrl, String content) updateAddedNews;

  // Constructor
  AddNewsViewModel({
    @required this.id,
    @required this.title,
    @required this.summary,
    @required this.imageUrl,
    @required this.content,
    @required this.updateAddedNews
  });

  factory AddNewsViewModel.fromStore(Store<AppState> store) {
    return AddNewsViewModel(
      id: store.state.addNewsState.id,
      title: store.state.addNewsState.title,
      summary: store.state.addNewsState.summary,
      imageUrl: store.state.addNewsState.imageUrl,
      content: store.state.addNewsState.content,
      updateAddedNews: (String id, String title, String summary,
          String imageUrl, String content) =>
        store.dispatch(UpdateAddedNewsAction(
            id: id,
            title: title,
            summary: summary,
            imageUrl: imageUrl,
            content: content))
    );
  }
}