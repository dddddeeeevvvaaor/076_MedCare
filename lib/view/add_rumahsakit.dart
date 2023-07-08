import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:medcare/controller/rumahsakit_controller.dart';
import 'package:medcare/model/obat_model.dart';
import 'package:medcare/model/rumahsakit_model.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/widgets/button.dart';

import 'home_page.dart';

class AddRumahSakit extends StatefulWidget {
  const AddRumahSakit({super.key});

  @override
  State<AddRumahSakit> createState() => _AddRumahSakitState();
}

class _AddRumahSakitState extends State<AddRumahSakit> {
  var rumahsakitController = RumahSakitController();

  final _formKey = GlobalKey<FormState>();

  String? poli;
  String? title;
  String? note;
  DateTime? date = DateTime.now();
  String? startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String? endTime = "9:30 PM";
  int color = 0;
  int remind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];
  String? repeat = "None";
  List<String> repeatList = ["None", "Daily", "Weekly", "Monthly"];

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
                  "Add Rumah Sakit",
                  style: HeadingStyle,
                ),
                //membuat dropdown button untuk memilih poli yang tersedia dan rumahsakitController.getPolis() untuk mengambil data dari controller
                Text(
                  "Poli",
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
                  child: FutureBuilder<List>(
                    future: rumahsakitController.getPolis(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: poli,
                            isExpanded: true,
                            hint: Text(
                              "Poli",
                              style: subTitleStyle,
                            ),
                            items: snapshot.data!.map((item) {
                              return DropdownMenuItem(
                                child: Text(
                                  item['nama'],
                                  style: subTitleStyle,
                                ),
                                value: item['nama'],
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                poli = value.toString();
                              });
                            },
                          ),
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ),
                
                Text(
                  "title",
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
                            hintText: "title",
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
                            if (value!.isEmpty) {
                              return "title cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                title = value;
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
                Text(
                  "Note",
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
                            hintText: "Note",
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
                            if (value!.isEmpty) {
                              return "Note cannot be empty";
                            } else {
                              return null;
                            }
                          },
                          onChanged: (value) {
                            setState(
                              () {
                                note = value;
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
                Text(
                  "Date",
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
                            hintText: DateFormat.yMMMMd().format(date!),
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
                          onChanged: (value) {
                            setState(
                              () {
                                date = DateTime.parse(value);
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          color: Colors.grey,
                        ),
                        onPressed: () {
                          _getDateFromUser();
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Start Time",
                            style: titleStyle,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.only(right: 8.0),
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
                                      hintText: startTime,
                                      hintStyle: subTitleStyle,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        startTime = value;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _getTimeFromUser(isStartTime: true);
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "End Time",
                            style: titleStyle,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            margin: const EdgeInsets.only(left: 8.0),
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
                                      hintText: endTime,
                                      hintStyle: subTitleStyle,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 12),
                                      border: InputBorder.none,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        endTime = value;
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    _getTimeFromUser(isStartTime: false);
                                  },
                                  icon: const Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Remind",
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
                            hintText: "$remind minutes early",
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
                          onChanged: (value) {
                            setState(() {
                              remind = value as int;
                            });
                          },
                        ),
                      ),
                      DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 24,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(
                          height: 0,
                        ),
                        items: remindList
                            .map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                              value: value.toString(),
                              child: Text(
                                value.toString(),
                                style: const TextStyle(color: Colors.grey),
                              ));
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            remind = int.parse(value!);
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Text(
                  "Repeat",
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
                            hintText: "$repeat",
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
                          onChanged: (value) {
                            setState(
                              () {
                                repeat = value;
                              },
                            );
                          },
                        ),
                      ),
                      DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 24,
                        elevation: 4,
                        style: subTitleStyle,
                        underline: Container(
                          height: 0,
                        ),
                        items: repeatList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            repeat = value!;
                          });
                        },
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
                    _colorPallete(),
                    MyButton(
                      label: "Save",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          RumahSakitModel ob = RumahSakitModel(
                            poli: poli!,
                            title: title!,
                            note: note!,
                            isCompleted: 0,
                            date: DateFormat.yMd().format(date!),
                            startTime: startTime!,
                            endTime: endTime!,
                            color: color!,
                            remind: remind!,
                            repeat: repeat!,
                          );

                          rumahsakitController.addRumahSakit(ob).then(
                            (_) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const HomePage(),
                                ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _colorPallete() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Color",
          style: titleStyle,
        ),
        const SizedBox(
          height: 8.0,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    color = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yellowClr,
                    // ignore: unrelated_type_equality_checks
                    child: color == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 16,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        )
      ],
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
      actions: const [
        CircleAvatar(
          //membuat image network menjadi widget agar gambar
          backgroundImage: NetworkImage(
              "https://static.wikia.nocookie.net/youtube/images/f/fd/Scary_dora.jpg/revision/latest?cb=20221205095142"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _getDateFromUser() async {
    DateTime? _pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2025));
    if (_pickerDate != null) {
      setState(() {
        date = _pickerDate;
      });
    } else {
      print("It's a null date selected");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var _pickedTime = await _showTimePicker();
    if (_pickedTime == null) {
      print("Time not picked");
    } else {
      String _formatedTime = _pickedTime.format(context);
      if (isStartTime) {
        setState(() {
          startTime = _formatedTime;
        });
      } else {
        setState(() {
          endTime = _formatedTime;
        });
      }
    }
  }

  _showTimePicker() {
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
      context: context,
      //_startTime-->10:30 AM (Format)
      initialTime: TimeOfDay(
        hour: int.parse(startTime!.split(":")[0]),
        minute: int.parse(startTime!.split(":")[1].split(" ")[0]),
      ),
    );
  }
}
