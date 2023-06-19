//import 'dart:ffi';
// import 'dart:async';
import 'dart:io';
import 'package:attend/auth/contactus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'attendviews2.dart';
import 'auth/loginpage.dart';
import 'auth/registration.dart';
import 'homepage.dart';
// import 'package:attend/auth/globallvariable.dart' as globals;
// import 'package:geolocator/geolocator.dart';

// import 'http_service.dart';

void main() {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Timer? _timer;
  //@override
  // void initState() {
  //   super.initState();
 
  //   _timer = Timer.periodic(Duration(seconds: globals.period), (timer) async {
  //     // setState(()  {

  //     try {
  //       if (globals.runingtimer) {
  //         Position position = await  _determinePosition();
  //         await HttpService.sendlocation(
  //             position.latitude, position.longitude, 0, globals.userId, 1);
  //       }

  //       // Navigator.of(context).pop();
  //     } catch (e) {
  //       EasyLoading.showSuccess("خطا: $e");
  //     }
  //   });
   
  // }

  // Future<Position> _determinePosition() async {
  //   bool servicesEnable;
  //   LocationPermission permission;
  //   servicesEnable = await Geolocator.isLocationServiceEnabled();
  //   if (!servicesEnable) {
  //     return Future.error('عفوا قم بتشغيل خدمة تحديد المواقع');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //     if (permission == LocationPermission.deniedForever) {
  //       return Future.error('نرجو اعطاء الصلاحية يدويا من الاعدادت');
  //     }
  //     //return Future.error('تم تعطيل صلاحية الوصول للموقع');
  //   }

  //   Position position = await Geolocator.getCurrentPosition();
  //   return position;
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.green,
          primaryColor: Color.fromARGB(255, 2, 43, 4),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.red),
          textTheme: const TextTheme(
              headline6: TextStyle(fontSize: 20, color: Colors.white))),
      home: const loginPage(),
      builder: EasyLoading.init(),
      routes: {
        "login": (context) => const loginPage(),
        "homepage": (context) => const homePage(),
        "register": (context) => const Signup(),
        "contact": (context) => contactus(),
        "attendview": (context) => HomePage(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
