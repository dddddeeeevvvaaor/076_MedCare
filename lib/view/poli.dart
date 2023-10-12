///mengimpor pustaka dan komponen yang diperlukan untuk mengembangkan halaman "Poli". Ini mencakup pustaka Flutter seperti package:flutter/material.dart, package:medcare/controller/poli_controller.dart, package:medcare/model/poli_model.dart, dan beberapa lainnya.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/poli_model.dart';
import 'package:medcare/view/add_poli.dart';
import 'package:medcare/view/edit_poli.dart';
import 'package:medcare/view/home_page.dart';

///Ini adalah kelas utama yang merupakan StatefulWidget. Kelas ini digunakan untuk membuat tampilan halaman "Poli" dan mengelola semua elemen di dalamnya.
class Poli extends StatefulWidget {
  ///ini adalah konstruktor yang menerima parameter key yang merupakan kunci untuk widget Poli.
  const Poli({super.key});

  @override
  State<Poli> createState() => _PoliState();
}

class _PoliState extends State<Poli> {
  var poli = PoliController();

  ///Metode initState digunakan untuk inisialisasi awal. Dalam kasus ini, itu digunakan untuk memanggil metode getPoli dari PoliController untuk mendapatkan daftar poli.
  @override
  void initState() {
    super.initState();
    poli.getPoli();
  }

  ///Metode build adalah bagian utama dari widget "Poli". Ini membangun tampilan halaman "Poli" dengan menggunakan widget-widget Flutter seperti Scaffold, Container, StreamBuilder, ListView.builder, Card, ListTile, CircleAvatar, IconButton, dan lainnya.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade400, Colors.indigo.shade700],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage:
                        NetworkImage('https://i.imgur.com/uRCRG.jpg'),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Contact',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<DocumentSnapshot>>(
                stream: poli.stream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final List<DocumentSnapshot> data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EditPoli(
                                  poliModel: PoliModel.fromMap(data[index]
                                      .data() as Map<String, dynamic>),
                                  poli: data[index],
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                  data[index]['nama']
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                data[index]['nama'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                color: Colors.red,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Delete Data',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        content: const Text(
                                          'Are you sure you want to delete this data?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              poli.deletePoli(data[index].id);
                                              poli.getPoli();
                                              Navigator.pop(context);
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Data ${data[index]['nama']} berhasil dihapus',
                                                  ),
                                                  backgroundColor: Colors.red,
                                                ),
                                              );
                                            },
                                            child: const Text(
                                              'Yes',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              'No',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      ///Ini adalah tombol tindakan mengambang yang digunakan untuk menavigasi ke halaman "AddPoli" saat ditekan.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddPoli(),
            ),
          );
        },
        // ignore: sort_child_properties_last
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.indigo,
      ),
    );
  }
}
