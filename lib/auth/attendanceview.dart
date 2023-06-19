// ignore: unused_import
import 'package:attend/auth/globallvariable.dart' as globals;
import 'package:flutter/material.dart';

// ignore: camel_case_types
class attendViews extends StatefulWidget {
  const attendViews({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _attendViewsState createState() => _attendViewsState();
}

// ignore: camel_case_types
class _attendViewsState extends State<attendViews> {
  double process = 0;
  List data = [
    {"name": "Iphone 6", "screen": "4.5", "price": "Rs.1,00,000"},
    {"name": "Iphone 7", "screen": "4.6", "price": "Rs.2,00,000"},
    {"name": "Iphone 8", "screen": "4.7", "price": "Rs.3,00,000"},
    {"name": "Iphone X", "screen": "5.0", "price": "Rs.4,00,000"},
  ];
  var usrMap = {"name": "Tom", 'Email': 'tom@xyz.com'};
  //String  name =  globals.userName==null:'-';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverToBoxAdapter(
                  // you could add any widget
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.transparent,
                    ),
                    title: Row(
                      children: <Widget>[
                        Expanded(child: Text("اليوم")),
                        Expanded(child: Text("الحالة")),
                        Expanded(child: Text("الساعات")),
                      ],
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return InkWell(
                        onTap: () {},
                        child: ListTile(
                          //return  ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.blue,
                            child: Text(data[index]["name"][0]),
                          ),
                          title: Row(
                            children: <Widget>[
                              Expanded(child: Text(data[index]["name"])),
                              Expanded(child: Text(data[index]["screen"])),
                              Expanded(child: Text(data[index]["price"])),
                            ],
                          ),
                        ),
                      );
                    },
                    // ignore: unnecessary_null_comparison
                    childCount: data == null ? 0 : data.length,
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
