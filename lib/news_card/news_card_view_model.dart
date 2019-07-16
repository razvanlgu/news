import 'package:meta/meta.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';

class NewsCardViewModel {
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final double expandHeight;
  final bool isFav;
  final bool isLiked;

  // Constructor
  NewsCardViewModel({
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

  factory NewsCardViewModel.fromStore(Store<AppState> store) {
    return NewsCardViewModel(
      id: store.state.newsCardState.id,
      title: store.state.newsCardState.title,
      summary: store.state.newsCardState.summary,
      imageUrl: store.state.newsCardState.imageUrl,
      likes: store.state.newsCardState.likes,
      dislikes: store.state.newsCardState.dislikes,
      expandHeight: store.state.newsCardState.expandHeight,
      isFav: store.state.newsCardState.isFav,
      isLiked: store.state.newsCardState.isLiked,
    );
  }
}