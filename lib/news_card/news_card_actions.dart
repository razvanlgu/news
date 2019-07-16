class GetCardInfoAction{
  final String newsId;

  GetCardInfoAction(this.newsId);
}

class UpdateCardInfoAction{
  final String id;
  final String title;
  final String summary;
  final String imageUrl;
  final int likes;
  final int dislikes;
  final double expandHeight;
  final bool isFav;
  final bool isLiked;

  UpdateCardInfoAction({
    this.id,
    this.title,
    this.summary,
    this.imageUrl,
    this.likes,
    this.dislikes,
    this.expandHeight,
    this.isFav,
    this.isLiked,
  });
}