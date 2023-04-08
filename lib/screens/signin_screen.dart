import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hackathon/const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hackathon/main.dart';
import 'package:hackathon/screens/forgotpassword_screen.dart';

class SignInScreen extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const SignInScreen({super.key, required this.onClickedSignUp});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool pass = true;
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void signinError() {
    setState(() {
      pass = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final verticalBlock = SizeConfig.safeBlockVertical!;

    final horizontalBlock = SizeConfig.safeBlockHorizontal!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "SIGN IN",
              style: TextStyle(color: blue, fontSize: verticalBlock * 5, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: verticalBlock * 7),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerShadow],
                color: Colors.white,
              ),
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: verticalBlock * 2, horizontal: horizontalBlock * 5),
                ),
                style: TextStyle(fontSize: verticalBlock * 2),
              ),
            ),
            SizedBox(
              height: verticalBlock * 2.5,
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerShadow],
                color: Colors.white,
              ),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: verticalBlock * 2, horizontal: horizontalBlock * 5),
                ),
                style: TextStyle(fontSize: verticalBlock * 2),
                obscureText: true,
              ),
            ),
            SizedBox(height: verticalBlock * 3),
            pass == false
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: horizontalBlock * 10),
                      child: Text('Incorrect username or password',
                          style: TextStyle(color: Colors.red, fontSize: verticalBlock * 2)),
                    ),
                  )
                : const Text(''),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
              ),
              child: Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                    left: horizontalBlock * 10,
                    right: horizontalBlock * 10,
                    bottom: verticalBlock * 4,
                    top: verticalBlock * 4),
                child: Text("Forgot your password?",
                    style: TextStyle(
                        color: blue, fontSize: verticalBlock * 2, decoration: TextDecoration.underline)),
              ),
            ),
            SizedBox(height: verticalBlock * 0.3),
            GestureDetector(
              onTap: signIn,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: blue,
                ),
                padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 12, vertical: verticalBlock * 2),
                margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
                child: Text("Sign in",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold, fontSize: verticalBlock * 2.3)),
              ),
            ),
            SizedBox(height: verticalBlock * 3.5),
            RichText(
                text: TextSpan(
                    text: "Don't have an accout?  ",
                    style: TextStyle(color: Colors.black, fontSize: verticalBlock * 1.8),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                      text: "Sign up",
                      style: TextStyle(
                          decoration: TextDecoration.underline, color: blue, fontSize: verticalBlock * 2))
                ])),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      signinError();
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
