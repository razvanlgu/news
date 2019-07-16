import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/entities/news_item.dart';

class GetNewsAction{}

class UpdateNewsAction{
  final List<String> idNews;

  UpdateNewsAction({this.idNews});
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

class MakeFav{
 final String id;

 MakeFav(this.id);
}

class Like{
  final String id;
  final bool isLike;
  Like(this.id,this.isLike);
}