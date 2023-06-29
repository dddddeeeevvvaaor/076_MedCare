import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:medcare/controller/obat_controller.dart';
import 'package:medcare/services/notification_services.dart';
import 'package:medcare/services/theme_services.dart';
import 'package:medcare/theme.dart';
import 'package:medcare/view/add_obat.dart';
import 'package:medcare/view/add_poli.dart';
import 'package:medcare/view/login.dart';
import 'package:medcare/widgets/button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var oc = ObatController();
    DateTime _selectedDate=DateTime.now();
  var notifyHelper;


    Future<void> _logout() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
      (route) => false,
    );
  }

  @override
  void initState() {
    super.initState();
    notifyHelper=NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
    oc.getObat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: _appBar(),
      backgroundColor: context.theme.backgroundColor,
      body:Column(
        children: [
          _addDateBar(),
                    _addBar(),
          const SizedBox(height: 10,),
        ],
      )
    );
  }
  _addDateBar(){
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle:GoogleFonts.lato(
          textStyle:const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        dayTextStyle:GoogleFonts.lato(
          textStyle:const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        monthTextStyle:GoogleFonts.lato(
          textStyle:const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate=date;
          });
        },
      ),
    );
  }
  //membuat dropdown button untuk memilih add obat atau add poli
  _addBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle,
                ),
                Text("Today",style:HeadingStyle,),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: 'Obat',
                items: const [
                  DropdownMenuItem(
                    child: Text('Obat'),
                    value: 'Obat',
                  ),
                  DropdownMenuItem(
                    child: Text('Poli'),
                    value: 'Poli',
                  ),
                ],
                onChanged: (value) {
                  if (value == 'Obat') {
                    Get.to(() => const AddObat());
                  } else if (value == 'Poli') {
                    Get.to(() => const AddPoli());
                  }
                },

              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(){
    return AppBar(
      elevation: 1,
      backgroundColor: context.theme.backgroundColor,
      leading:GestureDetector(
        onTap:(){
            ThemeService().switchTheme();
            notifyHelper.displayNotification(title:"Theme Changed",
                body: Get.isDarkMode?"Activated Light Theme":"Activated Dark Theme");
            //notifyHelper.scheduledNotification();
        },
        child: Icon(Get.isDarkMode?Icons.wb_sunny_outlined:Icons.nightlight_round,size: 20,
        color: Get.isDarkMode?Colors.white:Colors.black,),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: NetworkImage(
              "https://static.wikia.nocookie.net/youtube/images/f/fd/Scary_dora.jpg/revision/latest?cb=20221205095142"),
        ),
        SizedBox(width: 20,),
      ],
    );
  }
}