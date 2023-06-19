 

import 'package:contactus/contactus.dart';
import 'package:flutter/material.dart';
 

class contactus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 1, 44, 3),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          bottomNavigationBar: ContactUsBottomAppBar(
            companyName: 'alzawahed',
            textColor: Colors.white,
            backgroundColor: Color.fromARGB(255, 3, 58, 5),
            email: 'issa@alzawahed.com',
            // textFont: 'Sail',
          ),
          backgroundColor: Color.fromARGB(255, 2, 47, 3),
          body: ContactUs(
            cardColor: Colors.white,
            textColor: Color.fromARGB(255, 1, 46, 3),
            logo: AssetImage('images/logo.png'),
            email: 'issa@alzawahed.com',
            companyName: 'الزواهد للمقاولات',
            companyColor: Colors.green,
            dividerThickness: 2,
           // phoneNumber: '+593973046',
            tagLine: 'نظام التحضير',
            taglineColor: Colors.teal.shade100,
          ),
        ),
      ),
    );
  }
}
