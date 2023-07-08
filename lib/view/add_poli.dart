import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medcare/controller/poli_controller.dart';
import 'package:medcare/model/poli_model.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/view/home_page.dart';
import 'package:medcare/view/poli.dart';
import 'package:medcare/widgets/button.dart';

class AddPoli extends StatefulWidget {
  const AddPoli({Key? key}) : super(key: key);

  @override
  State<AddPoli> createState() => _AddPoliState();
}

class _AddPoliState extends State<AddPoli> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  var poliController = PoliController();
  final _formKey = GlobalKey<FormState>();

  String? nama;
  int? color = 0;
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
