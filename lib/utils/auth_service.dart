import 'package:dustbin_mangment/utils/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dustbin_mangment/models/driver.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;


  User firebaseUser;

  // create user obj based on firebase user
  Driver _userFromFirebaseUser(User user) {
    return user != null ? Driver(uid: user.uid) : null;
  }


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
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      // create a new document for the user with the uid
      await DatabaseService(uid: user.uid).updateUserData();
      return _userFromFirebaseUser(user);
    } catch (error) {
      print(error.toString());
      return null;
    }
  }




}