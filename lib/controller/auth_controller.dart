import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medcare/model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  bool get success => false;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          Uid: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      //print('Error signIn user: $e');
    }

    return null;
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser =
            UserModel(Uid: user.uid, email: user.email ?? '', name: name);

        await userCollection.doc(newUser.Uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user: $e');
    }

    return null;
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}

//controller untuk memasukkan passwrd ke database
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasematerial/model/user_model.dart';

class AuthController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  bool get success => false;

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final UserCredential userCredential = await auth
          .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final DocumentSnapshot snapshot =
            await userCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          Uid: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
          password: snapshot['password'] ?? '',
        );

        return currentUser;
      }
    } catch (e) {
      //print('Error signIn user: $e');
    }

    return null;
  }

  Future<UserModel?> registerWithEmailAndPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user != null) {
        final UserModel newUser =
            UserModel(Uid: user.uid, email: user.email ?? '', name: name, password: password);

        await userCollection.doc(newUser.Uid).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user: $e');
    }

    return null;
  }

  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
*/