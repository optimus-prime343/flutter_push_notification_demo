import 'package:dio/dio.dart';
import 'package:flutter_push_notification/models/notification_model.dart';

const String kUrl = 'https://api.jsonbin.io/v3/b/62f724455c146d63ca6bd07b';
final Dio dio = Dio();

class NotificationService {
  static Future<NotificationModel> getNotificationContent() async {
    Response response = await dio.get(kUrl);
    Map<String, dynamic> json = response.data['record'];
    NotificationModel notificationModel = NotificationModel.fromJSON(json);
    return notificationModel;
  }
}
