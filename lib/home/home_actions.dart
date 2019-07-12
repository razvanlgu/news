import 'package:news/entities/news_item.dart';

class GetNewsAction{}

class UpdateNewsAction{
  final List<NewsItem> news;

  UpdateNewsAction({this.news});
}

class ToggleNewsAction{
  final int index;

  ToggleNewsAction(this.index);
}

class NavigateToAddNewsPage {
}