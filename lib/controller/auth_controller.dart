///mengimpor beberapa pustaka yang diperlukan untuk mengelola otentikasi pengguna dan mengakses data Firestore, seperti package:cloud_firestore/cloud_firestore.dart dan package:firebase_auth/firebase_auth.dart. Ini juga mungkin termasuk model seperti UserModel yang digunakan dalam kode ini.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medcare/model/user_model.dart';

///ini adalah kelas yang bertanggung jawab untuk mengelola otentikasi pengguna dan interaksi dengan Firestore. Ini memiliki metode-metode yang digunakan untuk masuk, mendaftar, mengambil data pengguna saat ini, dan keluar.
class AuthController {
  ///ini adalah objek FirebaseAuth yang digunakan untuk mengelola otentikasi pengguna.
  final FirebaseAuth auth = FirebaseAuth.instance;
  ///ini adalah objek CollectionReference yang digunakan untuk mengelola data pengguna di Firestore.
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

///ini adalah getter yang mengembalikan nilai false. Ini digunakan untuk memeriksa apakah operasi yang dilakukan berhasil atau tidak.
  bool get success => false;

  ///ini adalah metode yang digunakan untuk melakukan otentikasi dengan email dan password. Ini mengambil email dan password sebagai argumen, mencoba melakukan masuk, dan jika berhasil, mengembalikan objek UserModel yang mewakili pengguna yang masuk.
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

  ///ini adalah metode yang digunakan untuk mendaftarkan pengguna baru dengan email, password, dan nama. Ini mengambil email, password, dan nama sebagai argumen, mencoba membuat pengguna baru, dan jika berhasil, mengembalikan objek UserModel yang mewakili pengguna baru.
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

  ///ini adalah metode yang digunakan untuk mengambil data pengguna saat ini yang sedang masuk. Ini mengambil pengguna saat ini dari objek FirebaseAuth dan mengembalikan objek UserModel yang sesuai.
  UserModel? getCurrentUser() {
    final User? user = auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebaseUser(user);
    }
    return null;
  }

  ///ini adalah metode yang digunakan untuk keluar dari sesi pengguna saat ini dengan Firebase Authentication.
  Future<void> signOut() async {
    await auth.signOut();
  }
}