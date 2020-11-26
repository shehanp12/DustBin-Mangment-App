import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future initialise() async {


    _fcm.configure(

      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
  }
}