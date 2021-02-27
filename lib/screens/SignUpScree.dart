import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lets_ride/main.dart';
import 'package:lets_ride/screens/HomeScreen.dart';
import 'package:lets_ride/screens/SignInScreen.dart';
import 'package:lets_ride/widgets/AuthTextField.dart';
import 'package:lets_ride/widgets/ShowProgress.dart';

class SignUpScreen extends StatefulWidget {
  static String id = '/SignUpScreen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController numberEditingController = TextEditingController();
  TextEditingController emailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  TextEditingController confirmPasswordEditingController =
      TextEditingController();

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
                width: 100.0,
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
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  children: [
                    AuthTextField(
                      lableText: 'Full Name',
                      textEditingController: nameEditingController,
                      iconData: Icons.person,
                      textInputType: TextInputType.name,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AuthTextField(
                      lableText: 'Phone Number',
                      hintText: '10 digit mobile number',
                      textEditingController: numberEditingController,
                      iconData: Icons.phone,
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AuthTextField(
                      lableText: 'Email',
                      hintText: 'email@example.com',
                      textEditingController: emailEditingController,
                      iconData: Icons.email_outlined,
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AuthTextField(
                      lableText: 'Password',
                      hintText: 'Enter min 8 characters',
                      textEditingController: passwordEditingController,
                      isPassword: true,
                      iconData: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    AuthTextField(
                      lableText: 'Confirm Password',
                      textEditingController: confirmPasswordEditingController,
                      isPassword: true,
                      iconData: Icons.lock_outline,
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, SignInScreen.id, (route) => false);
                          },
                          child: Container(
                            child: Text(
                              'Already have account?',
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
                        if (passwordEditingController.text.trim() ==
                                confirmPasswordEditingController.text.trim() &&
                            passwordEditingController.text.trim() != '' &&
                            confirmPasswordEditingController.text.trim() !=
                                '' &&
                            emailEditingController.text.trim() != '' &&
                            nameEditingController.text.trim() != '' &&
                            numberEditingController.text.trim() != '' &&
                            passwordEditingController.text.trim().length >= 8 &&
                            emailEditingController.text.trim().contains('@') &&
                            numberEditingController.text.trim().length >= 10) {
                          createUserAccount(context);
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
                            'SignUp',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    )
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
  void createUserAccount(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ShowProgress(
            message: "Please Wait",
          );
        });
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailEditingController.text,
                password: passwordEditingController.text)
            .catchError((errorMsg) {
      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: "Error:" + errorMsg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }))
        .user;
    if (firebaseUser != null) {
      Map userDataMap = {
        "name": nameEditingController.text.trim(),
        "email": emailEditingController.text.trim(),
        "number": numberEditingController.text.trim(),
      };
      userRef.child(firebaseUser.uid).set(userDataMap);
      Navigator.pushNamedAndRemoveUntil(
          context, HomeScreen.id, (route) => false);
    } else {
      Navigator.pop(context);

      Fluttertoast.showToast(
          msg: "New User not created",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
