
import 'package:equatable/equatable.dart';

class NewsModel extends Equatable {
  final String id;
  final String title;
  final String content;
  final String image;
  final String category;
  final int views;
  final DateTime createdAt;
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

  List<Object?> get props => [id, title,content,image,category,views,createdAt, updatedAt];
}