import 'package:chat_app/mainpage.dart';
import 'package:chat_app/register.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/src/material/colors.dart';
import 'already_have_an_account_check.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.green,
        primarySwatch: Colors.teal,
      ),
      home: LoginPage(),
      routes: {
        "/MainPage": (BuildContext content) => new MainPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.green;
  }
  return Colors.green;
}

bool value = false;

class _LoginPageState extends State<LoginPage> {
  bool _isHidden = true;
  bool _obsecuretext = true;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void _MainPage() {
      Navigator.popAndPushNamed(context, "/MainPage");
    }

    return SafeArea(
      child: (Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                ),
                Row(
                  children: [
                    Text.rich(TextSpan(
                      text: "Hello! Welcome back!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    )),
                    Text(
                      "👋",
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.0),
                Text(
                  "Hello again, You've been missed!",
                  style: TextStyle(
                    fontWeight: FontWeight.w200,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email Address",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide()),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff188F79),
                        ),
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(fontWeight: FontWeight.w100),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide()),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color(0xff188F79),
                        ),
                        hintText: 'Enter your password',
                        hintStyle: TextStyle(fontWeight: FontWeight.w100),
                        suffixIcon: InkWell(
                          onTap: _togglePassword,
                          child: Icon(
                            _isHidden ? Icons.visibility : Icons.visibility_off,
                            color: Color(0xff188F79),
                          ),
                        ),
                      ),
                      obscureText: _obsecuretext,
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              checkColor: Colors.white,
                              fillColor:
                                  MaterialStateProperty.resolveWith(getColor),
                              value: value,
                              onChanged: (bool? newvalue) {
                                setState(() {
                                  value = newvalue!;
                                });
                              },
                            ),
                            Text(
                              "Remember me",
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          "Forget Password",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.fromHeight(40),
                        primary: Color(0xff188F79),
                        // fromHeight use double.infinity as width and 40 is the height
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainPage()),
                        );
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    // Row(
                    //   children: [
                    //     Divider(
                    //       color: Colors.black,
                    //       thickness: 2,
                    //     ),
                    //     Text("Or Login with"),
                    //     const Divider(
                    //       height: 20,
                    //       thickness: 5,
                    //       indent: 20,
                    //       endIndent: 0,
                    //       color: Colors.black,
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 30,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     Container(
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: Color(0xffD7D7D7)),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               top: 8, bottom: 8, left: 8, right: 16),
                    //           child: Row(
                    //             children: [
                    //               Image.asset(
                    //                 'image/Facebook.png',
                    //                 scale: 1.4,
                    //               ),
                    //               Text("Facebook"),
                    //             ],
                    //           ),
                    //         )),
                    //     Container(
                    //         decoration: BoxDecoration(
                    //           border: Border.all(color: Color(0xffD7D7D7)),
                    //           borderRadius: BorderRadius.circular(10),
                    //         ),
                    //         child: Padding(
                    //           padding: const EdgeInsets.only(
                    //               top: 8, bottom: 8, left: 8, right: 16),
                    //           child: Row(
                    //             children: [
                    //               Image.asset(
                    //                 'image/Facebook.png',
                    //                 scale: 1.4,
                    //               ),
                    //               Text("Google"),
                    //             ],
                    //           ),
                    //         ))
                    //   ],
                    // )
                  ],
                ),
                SizedBox(
                  height: 205,
                ),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Registration();
                    }));
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

  void _togglePassword() {
    setState(() {
      _isHidden = !_isHidden;
      if (!_isHidden) {
        _obsecuretext = false;
      } else {
        _obsecuretext = true;
      }
    });
  }
}
