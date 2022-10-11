import 'package:chat_app/already_have_an_account_check.dart';
import 'package:chat_app/main.dart';
import 'package:chat_app/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login.dart';
import 'mainpage.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);
  static String verify = "";
  @override
  State<Registration> createState() => _RegistrationState();
}

Color getColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };
  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.blue;
}

bool value = false;

class _RegistrationState extends State<Registration> {
  @override
  bool _isHidden = true;
  bool _obsecuretext = true;
  TextEditingController phoneController = new TextEditingController();
  bool phoneNumPassed = false;
  String countryCode = '+91';
  final _emailController = new TextEditingController();
  final _passwordController = new TextEditingController();

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Text(
                "Create Account",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Connect with your Friends Today!",
                style: TextStyle(fontWeight: FontWeight.w200),
              ),
              SizedBox(
                height: 50,
              ),
              Text("Email Address",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide()),
                  hintText: 'Enter your email',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Color(0xff188F79),
                  ),
                  hintStyle: TextStyle(fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Phone Number",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide()),
                    hintText: '+91',
                    hintStyle: TextStyle(fontWeight: FontWeight.w100),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: Color(0xff188F79),
                    )),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Password", style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: _passwordController,
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
                      child: Icon(
                        _isHidden ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xff188F79),
                      ),
                      onTap: _togglePassword,
                    )),
                obscureText: _obsecuretext,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor: MaterialStateProperty.resolveWith(getColor),
                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: value,
                      onChanged: (bool? newvalue) {
                        setState(() {
                          value = newvalue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "I agree to the terms and condition",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(40),
                  primary: Color(0xff188F79),
                  // fromHeight use double.infinity as width and 40 is the height
                ),
                onPressed: () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    );
                  } on FirebaseAuthException catch (e) {
                    if (e.code == 'weak-password') {
                      print('The password provided is too weak.');
                    } else if (e.code == 'email-already-in-use') {
                      print('The account already exists for that email.');
                    }
                  } catch (e) {
                    print(e);
                  }
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: '${countryCode + phoneController.text}',
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      Registration.verify = verificationId;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => otp(
                                  phoneNumber:
                                      (phoneController.text.length) == 0
                                          ? ""
                                          : phoneController.text,
                                  phoneNumPassed:
                                      (phoneController.text.length) == 0
                                          ? false
                                          : true,
                                )),
                      );
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                },
                child: Text('Sign Up'),
              ),
              SizedBox(
                height: 160,
              ),
              AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }));
                  })
            ],
          ),
        ),
      ),
    ));
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
