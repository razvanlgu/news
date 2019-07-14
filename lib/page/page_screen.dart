import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:news/page/page_view_model.dart';
import 'package:news/redux/appstate.dart';
import 'package:news/resources/constants.dart';
import 'package:news/resources/news_icons_icons.dart';
import 'package:redux/redux.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';


class PageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    _screenWidth = MediaQuery.of(context).size.width;
//    _screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: StoreConnector<AppState, PageViewModel>(
        converter: (store) => PageViewModel.fromStore(store),
        builder: (context, pageViewModel) => _content(context, pageViewModel),
      ),
    );
  }


  _onInit(Store<AppState> store) {
  }

  Widget _content(BuildContext context, PageViewModel pageViewModel) {
   var _screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed:() => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: <Widget>[
          Container(
            padding: EdgeInsetsDirectional.only(bottom: 20.0),
            child: Text(
              pageViewModel.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Image.network(pageViewModel.imageUrl),
          Container(
            padding: EdgeInsetsDirectional.only(top: 20.0,bottom: 20.0),
            child: Text(
              '\t\t\t\t${pageViewModel.content}',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: NewsColors.textBorderColorFocused,
                  width: 2.0
              ),
            ),
            padding: EdgeInsetsDirectional.only(start: 15.0, end: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  '${pageViewModel.likes}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                IconButton(
                  color: Colors.black,
                  icon: Icon(NewsIcons.like),
                  onPressed: () => print('LIKE!!!'),
                ),
                Text(
                  '${pageViewModel.likes}',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                IconButton(
                  icon: Icon(NewsIcons.dislike),
                  onPressed: () => print('DISLIKE!!!'),
                ),
                Expanded(child: Container(),),
                IconButton(
                  color: Colors.black,
                  icon: Icon(Icons.favorite_border),
                  onPressed: () => print('ADD TO FAVORITE!!!'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
