import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

   String uid;
   DatabaseService({this.uid});


   final CollectionReference driverCollection = FirebaseFirestore.instance.collection('Drivers');

   Future<void> updateUserData() async {
     return await driverCollection.doc(uid).set({

     });
   }



}