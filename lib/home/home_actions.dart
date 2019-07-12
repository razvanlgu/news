import 'package:news/entities/news_item.dart';

class GetNewsAction{}

class UpdateNewsAction{
  final List<NewsItem> news;

  UpdateNewsAction({this.news});
}

class NavigateToAddNewsPage {
}