import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dustbin_mangment/models/driver.dart';

class DatabaseService{

  final Driver driver;
  final CollectionReference driverCollection = FirebaseFirestore.instance.collection('Drivers');
  DatabaseService(this.driver);

   Future<void>  addDriver(){

     return driverCollection.add({
       'email':driver.email,
       'address':driver.address,
       'fullName':driver.fullName,
       'nicNumber':driver.nicNumber,
       'phoneNumber':driver.phoneNumber,
       'vehicleNumber':driver.vehicleNumber

     });






   }



}