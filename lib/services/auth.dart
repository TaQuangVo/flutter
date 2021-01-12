import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  MyUser _convertUser(User user) {
    return user != null ? MyUser(uid: user.uid) : null;
  }

  // auth chnge user stream
  Stream<MyUser> get user {
    return _auth.authStateChanges().map((User user) => _convertUser(user));
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return _convertUser(user);
    } catch (e) {
      print(e);
      return null;
    }
  }

  //register with email and pwd
  Future signUp(String email, String pwd) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      MyUser user = _convertUser(result.user);
      DatabaseService brew = DatabaseService(uid: user.uid);
      await brew.updateUserData("0", "NewCrew", 100);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and pwd
  Future signIn(String email, String pwd) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      MyUser user = _convertUser(result.user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
