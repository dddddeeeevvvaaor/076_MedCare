import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/poli_model.dart';
import 'package:medcare/view/poli.dart';

class EditPoli extends StatefulWidget {
  PoliModel poliModel;
  EditPoli({
    Key? key,
    required DocumentSnapshot<Object?> poli,
    required this.poliModel,
  }) : super(key: key);

  @override
  State<EditPoli> createState() => _EditPoliState();
}

class _EditPoliState extends State<EditPoli> {
  var poliController = PoliController();

  final formKey = GlobalKey<FormState>();

  String? nama;

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
