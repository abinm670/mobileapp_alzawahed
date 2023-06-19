//import 'package:attend/auth/globallvariable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../http_service.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  late String email = '';
  late String userName = '';
  late String password = '';
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
          body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
              child: Icon(
            Icons.person,
            size: 80,
            color: Color.fromARGB(255, 17, 96, 21),
          ) //Image.asset(
              // "images/logoz.png",
              // width: 200,
              // height: 200,
              //  ),
              ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    TextFormField(
                        onChanged: (value) {
                          setState(() {
                            userName = value;
                          });
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        autocorrect: true,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'ادخل اسم المستخدم',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: ''),
                          //   errorText: 'ادخل كلمة المرور'),
                        ])),
                    const SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                        autocorrect: true,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'ادخل البريد الالكتروني  ',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: ''),
                          //   errorText: 'ادخل كلمة المرور'),
                        ])),
                    const SizedBox(
                      height: 3,
                    ),
                    TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                        obscureText: true,
                        // autocorrect: true,
                        textAlign: TextAlign.right,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.security),
                          hintText: 'ادخل كلمة المرور',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: ''),
                          //   errorText: 'ادخل كلمة المرور'),
                        ])),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed('login');
                            },
                            child: const Text(
                              'أضغط هنا لتسجيل الدخول',
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          const Text(
                            'اذا كان لديك حساب  ',
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: const Color.fromARGB(
                              255, 17, 96, 21), // Background color
                        ),
                        onPressed: () async {
                          if (_formkey.currentState?.validate() != false) {
                            try {
                            debugPrint(userName);
                            debugPrint(email);
                            debugPrint(password);
                            await HttpService.register(
                                userName, email, password, context);
                            } catch (e) {
                              await EasyLoading.showSuccess(
                                  "error 1= ${e.toString()}");
                            }
                          }
                        },
                        child: const Text(
                          'انشاء الحساب',
                          // style:Theme.of(context).textTheme.bodyText1.color.alpha,
                        ),
                      ),
                    )
                  ],
                )),
          )
        ],
      )),
    );
  }
}
