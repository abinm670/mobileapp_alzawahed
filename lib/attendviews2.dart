import 'dart:convert';
//import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:attend/auth/globallvariable.dart' as globals;
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Generate dummy data to feed the list view
  // final List _peopleData = List.generate(1000, (index) {
  //   return {"name": "Person \#$index", "age": Random().nextInt(90) + 10};
  // });

  final List _peopleData = [];
  Future getpost() async {
    var url = "https://secguardssys.com/appattendantlist?userid=${globals.userId}";

    var response = await http.get(Uri.parse(url));

    var respost = jsonDecode(response.body);
    // debugPrint("userid=${globals.userId}");
    _peopleData.addAll(respost);
    setState(() {});
  }

  // Item of the ListView

  Widget _listItem(index) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListTile(
        leading: Text(_peopleData[index][0].toString(),
            style: const TextStyle(fontSize: 18)),
        title: Text(
          _peopleData[index][1].toString(),
          style: const TextStyle(fontSize: 18),
        ),
        trailing: Text(_peopleData[index][2].toString(),
            style: const TextStyle(fontSize: 18, color: Colors.purple)),
      ),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black26))),
    );
  }

  @override
  void initState() {
    getpost();
    super.initState();
  }
  // void initState() {

  //   //debugPrint('Response body:  "${post[0]['title']}');
  //   super.initState();
  //     getpost();
  // }

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
                "سجل الحضور",
              ),
            ),
            backgroundColor: Color.fromARGB(255, 1, 49, 3),
          ),
          drawer: Drawer(
            child: Column(
              //UserAccountsDrawerHeader
              children: [
                const UserAccountsDrawerHeader(
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 2, 51, 3),
                      backgroundImage: AssetImage(
                        'images/logo.png',
                      ),
                      radius: 100,
                    ),

                    // ignore: unnecessary_null_comparison
                    accountName: Text("مرحبا"),
                    accountEmail: Text("")),
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
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                color: Colors.white,
                child: Card(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      //<-- SEE HERE
                      side: BorderSide(width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    leading: Text('اليوم'),
                    title: Text('الحالة'),
                    trailing: Text('الساعات'),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: _peopleData.length,
                    itemBuilder: (_, index) {
                      return _listItem(index);
                    }),
              ),
            ],
          )),
    );
  }
}
