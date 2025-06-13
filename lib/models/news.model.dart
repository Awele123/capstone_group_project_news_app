import 'package:hive/hive.dart';
import 'package:equatable/equatable.dart';

//part 'news.model.g.dart'; 

@HiveType(typeId: 0)
class NewsModel extends Equatable {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String content;

  @HiveField(3)
  final String image;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final int views;

  @HiveField(6)
  final DateTime createdAt;

  @HiveField(7)
  final DateTime updatedAt;

  const NewsModel({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.category,
    required this.views,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
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

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'content': content,
      'image': image,
      'category': category,
      'views': views,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        image,
        category,
        views,
        createdAt,
        updatedAt,
      ];
}
