import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medcare/controller/obat_controller.dart';
import 'package:medcare/controller/rumahsakit_controller.dart';
import 'package:medcare/model/obat_model.dart';
import 'package:medcare/model/rumahsakit_model.dart';
import 'package:medcare/services/notification_services.dart';
import 'package:medcare/services/theme_services.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/view/add_obat.dart';
import 'package:medcare/view/add_rumahsakit.dart';
import 'package:medcare/view/login.dart';
import 'package:medcare/view/poli.dart';
import 'package:medcare/widgets/button.dart';
import 'package:medcare/widgets/obattile.dart';
import 'package:medcare/widgets/rumahsakittile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime _selectedDate = DateTime.now();
  var oc = Get.put(ObatController());
  var rs = Get.put(RumahSakitController());
  var notifyHelper;

  Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    oc.getObat();
    rs.getRumahSakit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body: Column(
        children: [
          _addBar(),
          _addDateBar(),
          const SizedBox(
            height: 10,
          ),
          _showObatandRumahSakit(),
        ],
      ),
    );
  }

  _addDateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text(
                  "Today",
                  style: HeadingStyle,
                ),
              ],
            ),
          ),
          MyButton(
            //membuat dropdown untuk menampilkan menu add obat, add poli, dan logout
            label: "+Add",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Add"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            onTap: () {
                              Get.to(() => const Poli());
                            },
                            title: const Text("Poli"),
                            leading: const Icon(Icons.medication),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const AddObat());
                            },
                            title: const Text("Obat"),
                            leading: const Icon(Icons.medication),
                          ),
                          ListTile(
                            onTap: () {
                              Get.to(() => const AddRumahSakit());
                            },
                            title: const Text("Rumah Sakit"),
                            leading: const Icon(Icons.medication),
                          ),
                          ListTile(
                            onTap: () {
                              _logout();
                            },
                            title: const Text("Logout"),
                            leading: const Icon(Icons.logout),
                          ),
                        ],
                      ),
                    );
                  });
            },
          )
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      elevation: 1,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: "Theme Changed",
              body: Get.isDarkMode
                  ? "Activated Light Theme"
                  : "Activated Dark Theme");
          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://static.wikia.nocookie.net/youtube/images/f/fd/Scary_dora.jpg/revision/latest?cb=20221205095142"),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  _showObatandRumahSakit() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
          itemCount: oc.obatList.length + rs.rumahsakitList.length,
          itemBuilder: (_, index) {
            if (index < oc.obatList.length) {
              ObatModel obatModel = oc.obatList[index];
              if (obatModel.repeat == 'Weekly') {
                DateTime obatDate =
                    DateFormat.yMd().parse(obatModel.date.toString());
                if (obatDate.isBefore(_selectedDate.subtract(
                      const Duration(days: -1),
                    )) &&
                    obatDate.isAfter(_selectedDate.subtract(
                      const Duration(days: 7),
                    ))) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(obatModel.startTime.toString());
                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  if (obatModel.isCompleted == 0) {
                    notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      obatModel,
                    );
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, obatModel);
                              },
                              child: ObatTile(obatModel),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              } else if (obatModel.repeat == 'Monthly') {
                DateTime obatDate =
                    DateFormat.yMd().parse(obatModel.date.toString());
                if (obatDate.isBefore(_selectedDate.subtract(
                      const Duration(days: -1),
                    )) &&
                    obatDate.isAfter(_selectedDate.subtract(
                      const Duration(days: 30),
                    ))) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(obatModel.startTime.toString());
                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  if (obatModel.isCompleted == 0) {
                    notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      obatModel,
                    );
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheet(context, obatModel);
                              },
                              child: ObatTile(obatModel),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              } else if (obatModel.repeat == 'Daily') {
                if (obatModel.isCompleted == 0) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(obatModel.startTime.toString());

                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  notifyHelper.scheduledNotification(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      obatModel);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, obatModel);
                            },
                            child: ObatTile(obatModel),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            } else {
              int rsIndex = index - oc.obatList.length;
              RumahSakitModel rumahSakitModel = rs.rumahsakitList[rsIndex];
              if (rumahSakitModel.repeat == 'Weekly') {
                DateTime rumahSakitDate =
                    DateFormat.yMd().parse(rumahSakitModel.date.toString());
                if (rumahSakitDate.isBefore(_selectedDate.subtract(
                      const Duration(days: -1),
                    )) &&
                    rumahSakitDate.isAfter(_selectedDate.subtract(
                      const Duration(days: 7),
                    ))) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(rumahSakitModel.startTime.toString());
                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  if (rumahSakitModel.isCompleted == 0) {
                    notifyHelper.scheduledNotificationRumahSakit(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      rumahSakitModel,
                    );
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheetRumahSaki(
                                    context, rumahSakitModel);
                              },
                              child: RumahSakitTile(rumahSakitModel),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              } else if (rumahSakitModel.repeat == 'Monthly') {
                DateTime rumahSakitDate =
                    DateFormat.yMd().parse(rumahSakitModel.date.toString());
                if (rumahSakitDate.isBefore(_selectedDate.subtract(
                      const Duration(days: -1),
                    )) &&
                    rumahSakitDate.isAfter(_selectedDate.subtract(
                      const Duration(days: 30),
                    ))) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(rumahSakitModel.startTime.toString());
                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  if (rumahSakitModel.isCompleted == 0) {
                    notifyHelper.scheduledNotificationRumahSakit(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      rumahSakitModel,
                    );
                  }
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    child: SlideAnimation(
                      child: FadeInAnimation(
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showBottomSheetRumahSaki(
                                    context, rumahSakitModel);
                              },
                              child: RumahSakitTile(rumahSakitModel),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              } else if (rumahSakitModel.repeat == 'Daily') {
                if (rumahSakitModel.isCompleted == 0) {
                  DateTime date = DateFormat("hh:mm a")
                      .parse(rumahSakitModel.startTime.toString());

                  var myTime = DateFormat("HH:mm").format(date); //like 11.46
                  notifyHelper.scheduledNotificationRumahSakit(
                      int.parse(myTime.toString().split(":")[0]),
                      int.parse(myTime.toString().split(":")[1]),
                      rumahSakitModel);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheetRumahSaki(
                                  context, rumahSakitModel);
                            },
                            child: RumahSakitTile(rumahSakitModel),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return Container();
              }
            }
          },
        );
      }),
    );
  }

  _showBottomSheet(BuildContext context, ObatModel obatModel) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            height: obatModel.isCompleted == 1 ? 200 : 320,
            color: Get.isDarkMode ? darkGreyClr : Colors.white,
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 10),
                obatModel.isCompleted == 1
                    ? Container()
                    : _bottomSheetButton(
                        label: "Obat Completed",
                        onTap: () {
                          oc.markObatCompleted(obatModel.id!);
                          Get.back();
                        },
                        clr: primaryClr,
                        context: context,
                      ),
                _bottomSheetButton(
                  label: "Delete Obat",
                  onTap: () {
                    oc.deleteObat(obatModel.id!);
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context,
                ),
                const SizedBox(height: 20),
                _bottomSheetButton(
                  label: "Close",
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context: context,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomSheetButton(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[400]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose == true
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _showBottomSheetRumahSaki(
      BuildContext context, RumahSakitModel rumahSakitModel) {
    Get.bottomSheet(
      SingleChildScrollView(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(top: 4),
            height: rumahSakitModel.isCompleted == 1 ? 200 : 320,
            color: Get.isDarkMode ? darkGreyClr : Colors.white,
            child: Column(
              children: [
                Container(
                  height: 6,
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 10),
                rumahSakitModel.isCompleted == 1
                    ? Container()
                    : _bottomSheetButton(
                        label: "Rumah Sakit Completed",
                        onTap: () {
                          rs.markRumahSakitCompleted(rumahSakitModel.id!);
                          Get.back();
                        },
                        clr: primaryClr,
                        context: context,
                      ),
                _bottomSheetButton(
                  label: "Edit Obat",
                  onTap: () {
                    oc.deleteObat(rumahSakitModel.id!);
                    Get.back();
                  },
                  clr: Colors.green[300]!,
                  context: context,
                ),
                _bottomSheetButton(
                  label: "Delete Obat",
                  onTap: () {
                    rs.deleteRumahSakit(rumahSakitModel.id!);
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  context: context,
                ),
                const SizedBox(height: 20),
                _bottomSheetButton(
                  label: "Close",
                  onTap: () {
                    Get.back();
                  },
                  clr: Colors.red[300]!,
                  isClose: true,
                  context: context,
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _bottomSheetButtonRumahSakit(
      {required String label,
      required Function()? onTap,
      required Color clr,
      bool isClose = false,
      required BuildContext context}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        height: 40,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isClose == true
                ? Get.isDarkMode
                    ? Colors.grey[600]!
                    : Colors.grey[400]!
                : clr,
          ),
          borderRadius: BorderRadius.circular(20),
          color: isClose == true ? Colors.transparent : clr,
        ),
        child: Center(
          child: Text(
            label,
            style: isClose == true
                ? titleStyle
                : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return bluishClr;
      case 1:
        return pinkClr;
      case 2:
        return yellowClr;
      default:
        return bluishClr;
    }
  }
}
