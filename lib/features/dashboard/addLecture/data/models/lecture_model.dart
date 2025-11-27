// features/lectures/data/models/lectureModel.dart
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class LectureModel {
  String id;
  final String name;
  final String description;
  final String videoUrl;
  final String price;
  final String duration; // ممكن تكون "01:20" أو minutes

  final String stage; // المرحلة الدراسية
  bool isPlayList;
  final Timestamp createdAt; // ← خليه Timestamp

  LectureModel({
    required this.id,
    required this.price,
    required this.name,
    required this.description,
    required this.videoUrl,
    required this.stage,
    required this.duration,
    required this.isPlayList,
    Timestamp? createdAt,
  }) : createdAt = createdAt ?? Timestamp.now();

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'description': description,
      'videoUrl': videoUrl,
      'duration': duration,
      'stage': stage,
      'isPlayList': isPlayList,
      'createdAt': createdAt.millisecondsSinceEpoch, // 🔥 الحل
    };
  }

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] is int ? json['price'] : 0,
      videoUrl: json['videoUrl'] ?? '',
      duration: json['duration'] ?? '',
      stage: json['stage'] ?? '',
      isPlayList: json['isPlayList'] ?? false,
      createdAt: json['createdAt'] is Timestamp
          ? json['createdAt']
          : Timestamp.fromMillisecondsSinceEpoch(json['createdAt'] ?? 0),
    );
  }

  static String encodeList(List<LectureModel> list) {
    return jsonEncode(list.map((e) => e.toJson()).toList());
  }

  static List<LectureModel> decodeList(String jsonString) {
    final List parsed = jsonDecode(jsonString) as List;
    return parsed.map((e) => LectureModel.fromJson(e)).toList();
  }
}
