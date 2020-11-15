import 'package:dustbin_mangment/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dustbin_mangment/models/driver.dart';
import 'package:dustbin_mangment/utils/database.dart';
class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  User firebaseUser;





  Future signOut() async {
    try{
      return await _auth.signOut();





    }
    catch(e){
      print(e.toString());
      return null;

    }
  }
  // create user obj based on firebase user
  // Driver _userFromFirebaseUser(Driver driver) {
  //   return driver != null ? Driver() : null;
  // }


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
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
       await DatabaseService(driver).addDriver();
       print(result);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




}