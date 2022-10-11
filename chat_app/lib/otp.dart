import 'package:chat_app/mainpage.dart';
import 'package:chat_app/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pinput/pinput.dart';

class otp extends StatefulWidget {
  final String phoneNumber;

  final bool phoneNumPassed;
  const otp({Key? key, required this.phoneNumber, required this.phoneNumPassed})
      : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController sms = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xff188F79),
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message,
                      size: 50,
                      color: Color(0xff188F79),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "OTP verification",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      (widget.phoneNumPassed) == true
                          ? "Enter the code sent to the number"
                          : "Please ,enter your phone Number",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          (widget.phoneNumPassed) == true ? "+91" : "",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          widget.phoneNumber,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    (widget.phoneNumPassed) == true
                        ? Column(
                            children: [
                              Pinput(
                                length: 6,
                                controller: sms,
                                defaultPinTheme: defaultPinTheme,
                                focusedPinTheme: focusedPinTheme,
                                submittedPinTheme: submittedPinTheme,
                                // validator: (s) {
                                //   print('${sms} - sms');
                                //   print(s);
                                //   return s == sms ? null : 'Pin is incorrect';
                                // },
                                pinputAutovalidateMode:
                                    PinputAutovalidateMode.onSubmit,
                                showCursor: true,
                                onCompleted: (pin) => print(pin),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              SizedBox(
                                height: 45,
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () async {
                                      try {
                                        PhoneAuthCredential credential =
                                            PhoneAuthProvider.credential(
                                                verificationId:
                                                    Registration.verify,
                                                smsCode: sms.text);

                                        // Sign the user in (or link) with the credential
                                        await auth
                                            .signInWithCredential(credential);
                                        Navigator.pushNamed(context, "mainPg");
                                      } catch (e) {
                                        print("wrong otp");
                                      }
                                      // Create a PhoneAuthCredential with the code
                                    },
                                    child: Text("Verify phone number"),
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff188F79),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ))),
                              )
                            ],
                          )
                        : SizedBox(
                            height: 0,
                          ),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Edit your number ?",
                            style: TextStyle(
                                color: Color(0xff188F79),
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
