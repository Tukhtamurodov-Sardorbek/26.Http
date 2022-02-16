class Post {
  int? id;
  int? albumId;
  String? title;
  String? url;
  String? thumbnailUrl;


  Post({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl
  });

  Post.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        albumId = json['albumId'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'albumId': albumId,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl,
  };
}
