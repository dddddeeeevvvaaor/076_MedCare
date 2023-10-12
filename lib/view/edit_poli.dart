///mengimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode, termasuk komponen Flutter dan pustaka Firebase.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/poli_model.dart';
import 'package:medcare/view/poli.dart';

///Ini adalah kelas utama (EditPoli) yang merupakan StatefulWidget. Ini digunakan untuk membuat tampilan halaman edit poli dan mengelola semua elemen di dalamnya.
class EditPoli extends StatefulWidget {
  ///ini adalah variabel poliModel yang digunakan untuk menyimpan data poli yang akan diedit. Ini digunakan untuk mengisi nilai awal pada formulir. Ini juga digunakan untuk mengambil nilai yang dimasukkan oleh pengguna. Ini juga digunakan untuk mengirim data poli yang diedit ke metode updatePoli di PoliController. 
  PoliModel poliModel;
  ///ini adalah konstruktor yang menerima parameter key yang merupakan kunci untuk widget EditPoli. Ini juga menerima parameter poli yang merupakan objek DocumentSnapshot yang berisi data poli yang akan diedit. Ini juga menerima parameter poliModel yang merupakan objek PoliModel yang berisi data poli yang akan diedit. 
  EditPoli({
    Key? key,
    required DocumentSnapshot<Object?> poli,
    required this.poliModel,
  }) : super(key: key);

  @override
  State<EditPoli> createState() => _EditPoliState();
}

class _EditPoliState extends State<EditPoli> {
  ///Variabel poliController adalah objek dari PoliController, yang mungkin digunakan untuk mengelola data poli.
  var poliController = PoliController();

  ///ini adalah objek kunci global yang digunakan untuk mengelola keadaan formulir di dalam halaman. Ini memungkinkan untuk memeriksa validitas formulir dan mengakses nilai yang dimasukkan oleh pengguna.
  final formKey = GlobalKey<FormState>();

  ///Variabel nama adalah variabel String yang digunakan untuk menyimpan nama yang diinput oleh pengguna pada formulir.
  String? nama;

  ///Metode ini adalah bagian utama dari widget EditPoli. Ini membangun tampilan halaman edit poli dengan menggunakan widget-widget Flutter seperti Scaffold, AppBar, Form, TextFormField, ElevatedButton, dan lainnya. Metode ini juga memanggil metode lain yang digunakan untuk membangun bagian-bagian spesifik dari tampilan.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //membuat validasi nama gak boleh kosong
              TextFormField(
                controller: TextEditingController(
                  text: widget.poliModel.nama,
                ),
                decoration: InputDecoration(
                  labelText: 'Nama',
                  labelStyle: const TextStyle(color: Colors.indigo),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.indigo),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.indigo.withOpacity(0.5)),
                  ),
                ),
                style: const TextStyle(fontSize: 18),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama is required';
                  }
                  return null;
                },
                onChanged: (value) => nama = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                // ignore: sort_child_properties_last
                child: const Text(
                  'Update Contact',
                  style: TextStyle(fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.indigo,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    PoliModel pm = PoliModel(
                      id: widget.poliModel.id,
                      nama: nama ?? widget.poliModel.nama,
                    );
                    poliController.updatePoli(pm);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Contact Updated'),
                        duration: Duration(seconds: 1),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Poli(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
