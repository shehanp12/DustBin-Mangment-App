import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dustbin_mangment/models/driver.dart';

class DatabaseService{

  final Driver driver;
  final CollectionReference driverCollection = FirebaseFirestore.instance.collection('Drivers');
  DatabaseService(this.driver);
  final CollectionReference trucksCollection = FirebaseFirestore.instance.collection('Trucks');

   Future<void>  addDriver(uid){

     return driverCollection.doc(uid).set(
       {
         'email':driver.email,
         'address':driver.address,
         'fullName':driver.fullName,
         'nicNumber':driver.nicNumber,
         'phoneNumber':driver.phoneNumber,
         'vehicleNumber':driver.vehicleNumber,
         'login':driver.login

       }
     );




   }





}