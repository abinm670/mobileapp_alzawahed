import 'package:flutter/material.dart';
import 'package:attend/http_service.dart';
import 'package:form_field_validator/form_field_validator.dart';
// ignore: unused_import
import 'package:flutter_easyloading/flutter_easyloading.dart';
 
// ignore: camel_case_types
class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);

  @override
  
  State<loginPage> createState() => _loginPageState();
}

// ignore: camel_case_types
class _loginPageState extends State<loginPage> {
  late String username = '';
  late String password = '';
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: Card(
          child: Container(
            padding: const EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                    child: Icon(
                  Icons.lock_outline,
                  size: 80,
                  color: Color.fromARGB(255, 17, 96, 21),
                ) //Image.asset(
                    // "images/logoz.png",
                    // width: 200,
                    // height: 200,
                    //  ),
                    ),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                setState(() {
                                  username = value;
                                });
                              },
                              autocorrect: true,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                ),
                                isDense: true, // important line
                                contentPadding: EdgeInsets.fromLTRB(10, 10, 10,
                                    0), // control your hints text size

                                hintText: 'ادخل اسم المستخدم',

                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(width: 1),
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: ''),
                                //  errorText: 'ادخل اسم المستخدم'),
                              ])),
                          const SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              onChanged: (value) {
                                setState(() {
                                  password = value;
                                });
                              },
                              autocorrect: true,
                              obscureText: true,
                              textAlign: TextAlign.right,
                              decoration: const InputDecoration(
                                isDense: true, // important line
                                contentPadding: EdgeInsets.fromLTRB(10, 10, 10,
                                    0), // control your hints text size

                                prefixIcon: Icon(Icons.password),

                                hintText: 'ادخل كلمة المرور',
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(width: 3),
                                ),
                              ),
                              validator: MultiValidator([
                                RequiredValidator(errorText: ''),
                                //   errorText: 'ادخل كلمة المرور'),
                              ])),
                          Container(
                            margin: const EdgeInsets.all(10),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                  //  showAlert(context);
                                   Navigator.of(context).pushNamed('register');
                                  },
                                  child: const Text(
                                    'أضغط هنــــــــــا',
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        fontFamily: "NotoKufiArabic"),
                                  ),
                                ),
                                const Text(
                                  'للتسجيل ',
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(10),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor:
                                    const Color.fromARGB(255, 17, 96, 21),
                                shape: RoundedRectangleBorder(
                                    //to set border radius to button
                                    borderRadius: BorderRadius.circular(20)),
                                padding: const EdgeInsets.all(
                                    10), // Background color
                              ),
                              onPressed: () async {
                                // ignore: avoid_print
                                if (_formkey.currentState?.validate() !=
                                    false) {
                                  try {
                                    await HttpService.login(
                                        username, password, context);
                                  } catch (e) {
                                    await EasyLoading.showSuccess(
                                      e.toString() +  "عفواّ نرجو اعادة تشغيل التطبيق");
                                  }
                                }

                                //     .pushReplacementNamed("homepage");
                              },
                              child: const Text(
                                'تسجيل الدخول',
                                // style:Theme.of(context).textTheme.bodyText1.color.alpha,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
