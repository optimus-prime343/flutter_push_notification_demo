class NotificationModel {
  final int id;
  final String title;
  final String body;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory NotificationModel.fromJSON(Map<String, dynamic> json) {
    return NotificationModel(
      id: int.parse(json['id'].toString()),
      title: json['title'],
      body: json['body'],
    );
  }
}
