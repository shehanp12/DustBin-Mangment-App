import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class NotifcationService{

  String uid;
  final CollectionReference driverCollection = FirebaseFirestore.instance.collection('Drivers');

  final CollectionReference notificationCollection = FirebaseFirestore.instance.collection('notification');
  User user = FirebaseAuth.instance.currentUser;


  Future<void> onAcceptNotifcation(){

    return notificationCollection.add({
      'id':user.uid,
      'FullName':user.email,
      'Notification':'Aceepted'
    });
  }

  Future<void> onDeclineNotifcation(){

    return notificationCollection.add({
      'id':user.uid,
       'FullName':user.email,
      'Notification':'Declined'
    });
  }

  Future<void> logoutDriver(uid){

    return driverCollection.doc(uid).update({
      'login':false
    });







  }




}