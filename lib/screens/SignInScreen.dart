import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lets_ride/main.dart';
import 'package:lets_ride/screens/HomeScreen.dart';
import 'package:lets_ride/screens/SignUpScree.dart';
import 'package:lets_ride/widgets/AuthTextField.dart';
import 'package:lets_ride/widgets/ShowProgress.dart';

class SignInScreen extends StatefulWidget {
  static String id = '/SignInScreen';

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 40.0,
              ),
              Container(
                width: 180.0,
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  color: Colors.lightGreen[300],
                  borderRadius: BorderRadius.circular(200.0),
                ),
                child: Hero(
                  tag: 'hero',
                  child: Image.asset(
                    'assets/icons/appIcon.png',
                    alignment: Alignment.center,
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Let\'s Ride",
                textAlign: TextAlign.center,
                style: GoogleFonts.caveat(
                  fontSize: 50.0,
                  color: Colors.purple,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    AuthTextField(
                      lableText: 'Email',
                      textInputType: TextInputType.emailAddress,
                      textEditingController: emailEditingController,
                      iconData: Icons.email_outlined,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    AuthTextField(
                      lableText: 'Password',
                      isPassword: true,
                      textEditingController: passwordEditingController,
                      iconData: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignUpScreen.id, (route) => false);
                          },
                          child: Container(
                            child: Text(
                              'Don\'t have account?',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    GestureDetector(
                        onTap: () {
                          if (passwordEditingController.text.trim() != '' &&
                              emailEditingController.text.trim() != '' &&
                              passwordEditingController.text.trim().length >=
                                  8 &&
                              emailEditingController.text
                                  .trim()
                                  .contains('@')) {
                            loginUser(context);
                          } else {
                            Fluttertoast.showToast(
                                msg: "Check your Details",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: Colors.lightGreen,
                          ),
                          height: 50.0,
                          width: 150.0,
                          child: Center(
                            child: Text(
                              'SignIn',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void loginUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowProgress(
            message: "Please Wait",
          );
        });
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailEditingController.text,
                password: passwordEditingController.text)
            .catchError((errorMsg) {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "Error:" + errorMsg.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }))
        .user;

    if (firebaseUser != null) {
      userRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, HomeScreen.id, (route) => false);
        } else {
          Navigator.pop(context);

          _firebaseAuth.signOut();
          Fluttertoast.showToast(
              msg: "No account exist",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      });
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: "Error Occurred",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
