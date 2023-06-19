// ignore: unused_import
import 'dart:async';
 

import 'package:attend/auth/globallvariable.dart' as globals;
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:geolocator/geolocator.dart';

import 'http_service.dart';

// ignore: camel_case_types
class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override

  // ignore: library_private_types_in_public_api
  _homePageState createState() => _homePageState();
}

// ignore: camel_case_types
class _homePageState extends State<homePage> {
  double process = 0;

  autoattend_(bool isactive) {
   // debugPrint('stsrt===' + isactive.toString());
    
        Timer.periodic( Duration( minutes: globals.period), (Timer timer) async {
      //debugPrint('runing===' +
         // DateTime.now().toString() +
          //' ' +
        //  globals.runingtimer.toString());
         Position position = await  _determinePosition();
           await HttpService.sendlocation(
              position.latitude, position.longitude, 0, globals.userId, 1);
  
          if (!globals.runingtimer) {
      // cancel the timer
     // debugPrint('cancel===' +  globals.runingtimer.toString());
      timer.cancel();
    }
    });

    
  }

  //String  name =  globals.userName==null:'-';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          appBar: AppBar(
            // leading: IconButton(
            //   onPressed: () {},
            //   icon: const Icon(Icons.logout_outlined),
            // ),
            // actions: [
            //   IconButton(
            //       onPressed: () {
            //         if (Platform.isAndroid) {
            //           SystemNavigator.pop();
            //         } else if (Platform.isIOS) {
            //           exit(0);
            //         }
            //       },
            //       icon: const Icon(Icons.exit_to_app_sharp))
            // ],
            title: Center(
              child: Text(
                "${globals.userName} : مرحباً بك ",
              ),
            ),
            backgroundColor: Color.fromARGB(255, 2, 37, 3),
          ),
          drawer: Drawer(
            child: Column(
              //UserAccountsDrawerHeader
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                      'images/logo.png',
                    ),
                    radius: 100,
                  ),
                  // ignore: unnecessary_null_comparison
                  accountName: Text(' مرحبا: ' + globals.userName),
                  accountEmail: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(
                            255, 51, 87, 52) //elevated btton background color
                        ),
                    onPressed: () {
                      showAlert(context);
                    },
                    icon: Icon(
                        Icons.delete_forever), //icon data for elevated button
                    label: Text("حذف الحساب"), //label text
                  ),
                ),

                ListTile(
                  title: const Text("الرئيسية"),
                  leading: const Icon(Icons.home),
                  onTap: () {
                    Navigator.of(context).pushNamed("homepage");
                  },
                ),
                ListTile(
                  title: const Text("اتصل بنا"),
                  leading: const Icon(Icons.contact_page_outlined),
                  onTap: () {
                    Navigator.of(context).pushNamed("contact");
                  },
                ),
                ListTile(
                  title: const Text("الحضور"),
                  leading: const Icon(Icons.attachment),
                  onTap: () {
                    Navigator.of(context).pushNamed('attendview');
                  },
                ),
                ListTile(
                  title: const Text("خروج"),
                  leading: const Icon(Icons.exit_to_app),
                  onTap: () {
                    FlutterExitApp.exitApp();
                  },
                ),

                // ListTile(
                //   title: const Text("المهام الواردة"),
                //   leading: const Icon(Icons.task),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // ListTile(
                //   title: const Text("إرسال تقرير"),
                //   leading: const Icon(Icons.receipt),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
                // ListTile(
                //   title: const Text("المخالفات"),
                //   leading: const Icon(Icons.error),
                //   onTap: () {
                //     Navigator.pop(context);
                //   },
                // ),
              ],
            ),
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            color: Colors.white,
            child: Column(
                //  mainAxisAlignment: MainAxisAlignment.center
                children: [
                  Expanded(
                    flex: 4,
                    child: CircleAvatar(
                      radius: 120,
                      backgroundColor: Colors.white,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: ClipOval(
                          child: Image.asset(
                            "images/logoz.png",
                            // width: 200,
                            // height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ignore: avoid_unnecessary_containers
                  Expanded(
                    flex: 3,
                    child: Container(

                        // alignment: Alignment.bottomCenter,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 80,
                                  width: 100,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(25)),
                                  child: InkWell(
                                    splashColor: Colors.green,
                                    onTap: () async {
                                      globals.runingtimer = true;
                                      autoattend_(true);
                                      // setState(() {
                                      //   globals.runingtimer = true;
                                      // });
                                      // debugPrint( 'homepage' + (globals.period ).toString()    );

                                      //  globals.autoattend.call(globals.runingtimer);
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 5),
                                            );
                                          });
                                      try {
                                        Position position =
                                            await _determinePosition();

                                        await HttpService.sendlocation(
                                            position.latitude,
                                            position.longitude,
                                            0,
                                            globals.userId,
                                            0);
                                        Navigator.of(context).pop();
                                      } catch (e) {
                                        EasyLoading.showSuccess("خطا: $e");
                                      }
                                    },
                                    child: const Text(
                                      "الحضور",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),

                                    //
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      height: 80,
                                      width: 100,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: InkWell(
                                        onTap: () async {
                                          globals.runingtimer = false;
                                          autoattend_(false);
                                          // setState(() {
                                          //   globals.runingtimer = false;
                                          // });
                                          // globals.runingtimer = false;
                                          //  globals.autoattend.call(globals.runingtimer);
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 5),
                                                );
                                              });
                                          try {
                                            Position position =
                                                await _determinePosition();

                                            await HttpService.sendlocation(
                                                position.latitude,
                                                position.longitude,
                                                1,
                                                globals.userId,
                                                0);

                                            Navigator.of(context).pop();
                                          } catch (e) {
                                            EasyLoading.showSuccess("خطا: $e");
                                          }
                                        },
                                        child: const Text(
                                          "الانصراف",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )),
                  )
                ]),
          )),
    );
  }

  Future<Position> _determinePosition() async {
    bool servicesEnable;
    LocationPermission permission;
    servicesEnable = await Geolocator.isLocationServiceEnabled();
    if (!servicesEnable) {
      return Future.error('عفوا قم بتشغيل خدمة تحديد المواقع');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error('نرجو اعطاء الصلاحية يدويا من الاعدادت');
      }
      //return Future.error('تم تعطيل صلاحية الوصول للموقع');
    }

    Position position = await Geolocator.getCurrentPosition();
    return position;
  }

  void showAlert(BuildContext context) {
    // ignore: unused_local_variable
    Widget okBton = ElevatedButton(
      child: Text('موافق'),
      onPressed: () async {
        try {
          await HttpService.deleteuse(globals.userId, context);
          Navigator.of(context).pushReplacementNamed("login");
        } catch (e) {
          await EasyLoading.showSuccess(e.toString());
        }
      },
    );
    Widget cancelBton = ElevatedButton(
      child: Text('الغاء'),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("تحذير"),
      content: Text(
        'هل تود بالفعل حذف حسابك؟',
        textAlign: TextAlign.right,
        textDirection: TextDirection.rtl,
      ),
      actions: [okBton, cancelBton],
    );
    showDialog(
        context: context,
        builder: (BuildContext buildContext) {
          return alert;
        });
  }
}
