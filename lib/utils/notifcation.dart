import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dustbin_mangment/models/driver.dart';
import 'package:dustbin_mangment/utils/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NotifcationService{

  String uid;
  final CollectionReference driverCollection = FirebaseFirestore.instance.collection('Drivers');

  final CollectionReference notificationCollection = FirebaseFirestore.instance.collection('notification');
  User user = FirebaseAuth.instance.currentUser;


  Future<void> onAcceptNotifcation(){

    return notificationCollection.add({
      'id':user.uid,
      'Full Name':user.email,
      'Notification':'Aceepted'
    });
  }

  Future<void> onDeclineNotifcation(){

    return notificationCollection.add({
      'id':user.uid,
       'Full Name':user.email,
      'Notification':'Aceepted'
    });
  }


}