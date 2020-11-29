import 'package:dustbin_mangment/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dustbin_mangment/models/driver.dart';
class AuthService{
   Driver driver;
  final FirebaseAuth _auth = FirebaseAuth.instance;


   final User user = FirebaseAuth.instance.currentUser;








   Future signOut() async {
    try{

      return await _auth.signOut();






    }
    catch(e){
      print(e.toString());
      return null;

    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email:email, password: password);

      User user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(Driver driver, String password) async {
    try {

       UserCredential result = await _auth.createUserWithEmailAndPassword(email: driver.email, password: password);
       String uid =FirebaseAuth.instance.currentUser.uid.toString();
       await DatabaseService(driver).addDriver(uid);

       print(result);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




}