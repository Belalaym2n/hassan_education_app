import '../../../dashboard/addLecture/data/models/lecture_model.dart';

class PlaylistModel {
  final String id;
  final String name;
  final String description;
   final String price;
    String playListFirstVideo;

  List<LectureModel> lectures;

  PlaylistModel({
    required this.id,
    required this.name,
    required this.price,
    required this.playListFirstVideo,
    required this.description,
     this.lectures = const [],
  });

  factory PlaylistModel.fromJson(Map<String, dynamic> json, ) {
    return PlaylistModel(
      id: json["id"],
      name: json['name']?.toString() ?? "",
      description: json['description']?.toString() ?? "",
       price: json['price']?.toString() ?? "",
      playListFirstVideo: json['play_list_first_video']?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "price": price,
      "description": description,
       "play_list_first_video": playListFirstVideo,
    };
  }
}
