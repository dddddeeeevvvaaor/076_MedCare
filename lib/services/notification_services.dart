///mengimpor semua pustaka dan komponen yang diperlukan untuk digunakan dalam kode. Ini termasuk berbagai pustaka seperti Flutter, Flutter Local Notifications, GetX, model ObatModel dan RumahSakitModel, serta beberapa pustaka pendukung lainnya.
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:medcare/model/obat_model.dart';
import 'package:medcare/model/rumahsakit_model.dart';
import 'package:medcare/notified_page.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

///Ini adalah kelas yang bertanggung jawab untuk mengelola notifikasi dalam aplikasi.
class NotifyHelper {
  ///ini adalah objek dari FlutterLocalNotificationsPlugin yang digunakan untuk mengelola notifikasi lokal dalam aplikasi.
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  ///ini adalah metode yang digunakan untuk menginisialisasi pengaturan notifikasi lokal. Ini mencakup inisialisasi pengaturan Android dan menginisialisasi FlutterLocalNotificationsPlugin.
  initializeNotification() async {
    //tz.initializeTimeZones();
    _configureLocalTimezone();

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("appicon");

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings, /*onSelectNotification: selectNotification*/
    );
  }

  ///ini adalah metode yang digunakan untuk menampilkan notifikasi dengan judul dan isi yang ditentukan. Ini menggunakan FlutterLocalNotificationsPlugin untuk menampilkan notifikasi.
  displayNotification({required String title, required String body}) async {
    print("doing test");
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
        'your channel id', 'your channel name' /*, 'your channel description'*/,
        importance: Importance.max, priority: Priority.high);
    var platformChannelSpecifics =
        new NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: title,
    );
  }

  ///ini adalah metode yang digunakan untuk meminta izin notifikasi pada platform iOS. Ini berlaku hanya untuk perangkat iOS.
  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  ///ini adalah metode yang digunakan untuk menjadwalkan notifikasi pada waktu yang ditentukan. Ini menggunakan FlutterLocalNotificationsPlugin untuk menjadwalkan notifikasi berdasarkan model ObatModel yang diberikan.
  scheduledNotification(int hour, int minutes, ObatModel oml) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        oml.id!.toString().hashCode,
        oml.title,
        oml.note,
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name' /*, 'your channel description'*/)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${oml.title}|" + "${oml.note}|");
  }

  ///ini adalah metode yang digunakan untuk menjadwalkan notifikasi rumah sakit pada waktu yang ditentukan. Ini juga menggunakan FlutterLocalNotificationsPlugin untuk menjadwalkan notifikasi berdasarkan model RumahSakitModel yang diberikan.
  scheduledNotificationRumahSakit(
      int hour, int minutes, RumahSakitModel rsm) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        rsm.id!.toString().hashCode,
        rsm.title,
        rsm.note,
        _convertTime(hour, minutes),
        //tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name' /*, 'your channel description'*/)),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: "${rsm.title}|" + "${rsm.note}|");
  }

  ///ini adalah metode yang dipanggil saat notifikasi dipilih atau ditekan. Ini memeriksa payload notifikasi dan berperilaku berbeda tergantung pada payload yang diberikan. Jika payload adalah "Theme Changed," maka perubahan tema akan diterapkan, dan jika payload adalah yang lain, maka akan membuka halaman NotifiedPage.
  Future selectNotification(String? payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    } else {
      print("Notification Done");
    }
    if (payload == "Theme Changed") {
      print("Eat 5 star");
    } else {
      Get.to(() => NotifiedPage(label: payload));
    }
  }

  ///ini adalah metode yang dipanggil ketika notifikasi lokal diterima oleh perangkat. Dalam contoh ini, ia menampilkan dialog sederhana yang menyambut pengguna ke dalam aplikasi Flutter.
  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    Get.dialog(Text("Welcome to Flutterrr"));
  }

  ///ini adalah metode internal yang digunakan untuk mengonversi waktu dalam zona waktu tertentu ke objek TZDateTime. Ini digunakan saat menjadwalkan notifikasi untuk menentukan waktu yang tepat untuk notifikasi berdasarkan jam dan menit yang diberikan.
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minutes);
    print("tz is  $scheduleDate");
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  ///ini adalah metode internal yang digunakan untuk menginisialisasi zona waktu lokal di aplikasi. Ini penting untuk mengatur zona waktu yang benar saat menjadwalkan notifikasi.
  Future<void> _configureLocalTimezone() async {
    tz.initializeTimeZones();
    final String timeZone = await DateTime.now().timeZoneName;
    print(timeZone);
  }
}
