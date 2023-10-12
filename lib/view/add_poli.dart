///engimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode, termasuk flutter/material.dart, get/get.dart, medcare/controller/poli_controller.dart, medcare/model/poli_model.dart, medcare/theme.dart, medcare/view/home_page.dart, medcare/view/poli.dart, dan medcare/widgets/button.dart.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/poli_model.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/view/home_page.dart';
import 'package:medcare/view/poli.dart';
import 'package:medcare/widgets/button.dart';

///Ini adalah kelas utama yang merupakan StatefulWidget. Ini digunakan untuk membuat tampilan halaman penambahan poli dan mengelola semua elemen di dalamnya.
class AddPoli extends StatefulWidget {
  ///ini adalah konstruktor yang menerima parameter key yang merupakan kunci untuk widget AddPoli.
  const AddPoli({Key? key}) : super(key: key);

  @override
  State<AddPoli> createState() => _AddPoliState();
}

class _AddPoliState extends State<AddPoli> {
  ///ini adalah objek TextEditingController yang digunakan untuk mengontrol input teks untuk judul dan catatan.
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  ///ini adalah objek dari PoliController, yang mungkin digunakan untuk mengelola data poli.
  var poliController = PoliController();

  ///ini adalah objek kunci global yang digunakan untuk mengelola keadaan formulir di dalam halaman. Ini memungkinkan untuk memeriksa validitas formulir dan mengakses nilai yang dimasukkan oleh pengguna.
  final _formKey = GlobalKey<FormState>();

  ///ini adalah variabel nullable yang digunakan untuk menyimpan nama poli yang dimasukkan oleh pengguna.
  String? nama;

  ///ini adalah variabel nullable yang tampaknya belum digunakan dalam kode ini.
  int? color = 0;

  ///Metode ini adalah bagian utama dari widget AddPoli. Ini membangun tampilan halaman penambahan poli dengan menggunakan widget-widget Flutter seperti Scaffold, Container, Text, TextFormField, MyButton, dan lainnya. Metode ini juga menangani validasi input dan menyimpan data saat tombol "Save" ditekan.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appBar(context),
      body: Container(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add text",
                  style: HeadingStyle,
                ),
                Text(
                  "Nama Poli",
                  style: titleStyle,
                ),
                Container(
                  height: 52,
                  margin: const EdgeInsets.only(top: 8.0),
                  padding: const EdgeInsets.only(left: 12, right: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          autofocus: false,
                          cursorColor: Get.isDarkMode
                              ? Colors.grey[100]
                              : Colors.grey[700],
                          style: subTitleStyle,
                          decoration: InputDecoration(
                            hintText: "Nama Poli",
                            hintStyle: subTitleStyle,
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0,
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: context.theme.backgroundColor,
                                width: 0,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Nama Poli tidak boleh kosong";
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                nama = value;
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyButton(
                      label: "Save",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          PoliModel pm = PoliModel(
                            nama: nama!,
                          );

                          poliController.addPoli(pm).then(
                            (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Poli(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

///ini adalah metode yang membangun AppBar pada halaman penambahan poli. Ini termasuk tombol kembali dan avatar pengguna yang terhubung.
  _appBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
              "https://static.wikia.nocookie.net/youtube/images/f/fd/Scary_dora.jpg/revision/latest?cb=20221205095142"),
        ),
        const SizedBox(
          width: 20,
        ),
      ],
    );
  }
}
