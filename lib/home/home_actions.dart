import 'package:news/entities/news_item.dart';

class GetNewsAction{}

class UpdateNewsAction{
  final List<NewsItem> news;

  UpdateNewsAction({this.news});
}

class ToggleNewsAction{
  final String id;

  ToggleNewsAction(this.id);
}

class GetNewsPageAction{
  final String id;

  GetNewsPageAction(this.id);
}

class NavigateToAddNewsPage {
}


class NavigateToNewsPage {
}