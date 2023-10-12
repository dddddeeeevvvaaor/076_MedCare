///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan halaman "Login". Ini mencakup pustaka Flutter seperti package:flutter/material.dart, package:medcare/controller/auth_controller.dart, package:medcare/model/user_model.dart, package:medcare/view/home_page.dart, dan package:medcare/view/register.dart.
import 'package:flutter/material.dart';
import 'package:medcare/controller/auth_controller.dart';
import 'package:medcare/model/user_model.dart';
import 'package:medcare/view/home_page.dart';
import 'package:medcare/view/register.dart';

///Ini adalah kelas utama yang merupakan StatefulWidget. Kelas ini digunakan untuk membuat tampilan halaman "Login" dan mengelola semua elemen di dalamnya.
class Login extends StatefulWidget {
  ///ini adalah konstruktor yang menerima parameter key yang merupakan kunci untuk widget Login.
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ///Variabel boolean _isObscure digunakan untuk mengontrol apakah teks kata sandi harus ditampilkan dalam bentuk tersembunyi atau tidak.
  bool _isObscure = true;

  ///Variabel form adalah objek GlobalKey<FormState> yang digunakan untuk mengelola keadaan formulir di dalam halaman. Ini memungkinkan untuk memeriksa validitas formulir dan mengakses nilai yang dimasukkan oleh pengguna.
  final form = GlobalKey<FormState>();

  ///Variabel authCr adalah objek dari AuthController, yang mungkin digunakan untuk mengelola otentikasi pengguna.
  final authCr = AuthController();

  ///mendeklarasikan dua variabel String, yaitu email dan password, untuk menyimpan data yang dimasukkan oleh pengguna pada formulir.
  String? email;
  String? password;

  ///Metode build adalah bagian utama dari widget "Login". Ini membangun tampilan halaman "Login" dengan menggunakan widget-widget Flutter seperti Scaffold, Container, Form, TextFormField, ElevatedButton, TextButton, dan lainnya.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade200, Colors.blue.shade400],
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
                    'Login',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.blue.shade400,
                      ),
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
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.blue.shade400,
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: Icon(
                          _isObscure ? Icons.visibility : Icons.visibility_off,
                          color: Colors.blue.shade400,
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
                        UserModel? user =
                            await authCr.signInWithEmailAndPassword(
                          email!,
                          password!,
                        );
                        if (user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Selamat Datang ${user.name}'),
                              backgroundColor: Colors.green,
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Email atau Password yang anda masukkan salah',
                              ),
                              backgroundColor: Colors.red,
                              duration: Duration(seconds: 3),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue.shade400,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Register(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 16),
                    ),
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
