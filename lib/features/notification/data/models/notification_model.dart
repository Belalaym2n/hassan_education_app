class NotificationModel {
  final String title;
  final String message;
  final DateTime createdAt;

  NotificationModel({
    required this.title,
    required this.message,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['headings']?['en'] ?? '',
      message:        json['contents']?['en'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
    );
  }


}
