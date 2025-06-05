
class News {
  final String id;
  final String title;
  final String content;
  final String image;
  final String category;
  final int views;
  final DateTime createdAt;
  final DateTime updatedAt;

  News({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.category,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['_id'].toString(),
      title: json['title'],
      content: json['content'],
      image: json['image'],
      category: json['category'],
      views: int.parse(json['views'].toString()),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}