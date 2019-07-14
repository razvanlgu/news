import 'package:meta/meta.dart';
import 'package:news/redux/appstate.dart';
import 'package:redux/redux.dart';



class PageViewModel {
  final String title;
  final String imageUrl;
  final String content;
  final int likes;
  final int dislikes;

  // Constructor
  PageViewModel({
    @required this.title,
    @required this.imageUrl,
    @required this.content,
    @required this.likes,
    @required this.dislikes,
  });

  factory PageViewModel.fromStore(Store<AppState> store) {
    return PageViewModel(
      title: store.state.pageState.title,
      imageUrl: store.state.pageState.imageUrl,
      content: store.state.pageState.content,
      likes: store.state.pageState.likes,
      dislikes: store.state.pageState.dislikes,
    );
  }
}