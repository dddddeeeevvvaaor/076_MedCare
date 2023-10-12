///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan halaman Registrasi. Ini mencakup pustaka Flutter seperti package:flutter/material.dart, package:medcare/controller/auth_controller.dart, dan package:medcare/model/user_model.dart.
import 'package:flutter/material.dart';
import 'package:medcare/controller/auth_controller.dart';
import 'package:medcare/model/user_model.dart';
import 'package:medcare/view/login.dart';

///Ini adalah kelas utama yang merupakan StatefulWidget. Kelas ini digunakan untuk membuat tampilan halaman Registrasi dan mengelola semua elemen di dalamnya.
class Register extends StatefulWidget {
  ///ini adalah konstruktor yang menerima parameter key yang merupakan kunci untuk widget Register.
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ///Variabel boolean _isObscure digunakan untuk mengontrol apakah teks password harus ditampilkan dalam bentuk tersembunyi atau tidak.
  bool _isObscure = true;

  ///Ini adalah objek kunci global yang digunakan untuk mengelola keadaan formulir di dalam halaman. Ini memungkinkan untuk memeriksa validitas formulir dan mengakses nilai yang dimasukkan oleh pengguna.
  final form = GlobalKey<FormState>();

  ///Ini adalah objek dari AuthController, yang digunakan untuk mengelola otentikasi pengguna.
  final auth = AuthController();

  ///mendeklarasikan beberapa variabel String seperti nama, email, dan password untuk menyimpan data yang diisi oleh pengguna pada formulir.
  String? name;
  String? email;
  String? password;

///Metode build adalah bagian utama dari widget Register. Ini membangun tampilan halaman registrasi dengan menggunakan widget-widget Flutter seperti Scaffold, Container, TextFormField, ElevatedButton, dan lainnya. Metode ini juga memanggil metode lain yang digunakan untuk membangun bagian-bagian spesifik dari tampilan.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF73AEF5),
              Color(0xFF61A4F1),
              Color(0xFF478DE0),
              Color(0xFF398AE5),
            ],
            stops: [0.1, 0.4, 0.7, 0.9],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: form,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.person),
                    ),
                    onChanged: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Name tidak boleh kosong';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.email),
                    ),
                    onChanged: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email tidak boleh kosong';
                      } else if (!value.contains('@')) {
                        return 'Email harus mengandung @';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Icon(Icons.lock),
                      ///Metode ini digunakan untuk mengganti status _isObscure, yang mengubah tampilan teks password menjadi tersembunyi atau terlihat.
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        password = value;
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Password tidak boleh kosong';
                      } else if (value.length < 6) {
                        return 'Password minimal 6 karakter';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      if (form.currentState!.validate()) {
                        UserModel? registeredUser =
                        ///Metode ini digunakan untuk menampilkan dialog pemrosesan saat pengguna menekan tombol registrasi. Ini juga memanggil metode registerWithEmailAndPassword dari AuthController untuk melakukan pendaftaran pengguna dengan email, password, dan nama yang telah diisi.
                            await auth.registerWithEmailAndPassword(
                                email!, password!, name!);
                        if (registeredUser != null) {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Success'),
                                content: const Text('Register Success'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Welcome ${registeredUser.name}',
                                          ),
                                          backgroundColor: Colors.green,
                                          duration: const Duration(seconds: 3),
                                        ),
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Error'),
                                content: const Text('Register Failed'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    child: const Text('Register'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Login(),
                            ),
                          );
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
