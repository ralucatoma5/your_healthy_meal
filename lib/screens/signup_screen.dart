import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../const.dart';
import '../main.dart';

class SignUpScreen extends StatefulWidget {
  final Function() onClickedSignIn;
  SignUpScreen({Key? key, required this.onClickedSignIn}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool pass = true;
  void signUpError() {
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
      backgroundColor: blue,
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/signup_top.png',
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(top: verticalBlock * 2, bottom: verticalBlock * 12),
              child: Text(
                "SIGN UP",
                style:
                    TextStyle(color: Colors.white, fontSize: verticalBlock * 5, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerShadow],
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: TextFormField(
                controller: emailController,
                style: TextStyle(color: blue, fontSize: verticalBlock * 2),
                decoration: InputDecoration(
                    labelText: "Email",
                    labelStyle: TextStyle(color: blue),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: verticalBlock, horizontal: horizontalBlock * 5)),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    (email != null && !EmailValidator.validate(email)) ? 'Enter a valid email' : null,
              ),
            ),
            SizedBox(
              height: verticalBlock * 2.5,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerShadow],
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: TextFormField(
                controller: passwordController,
                style: TextStyle(color: blue, fontSize: verticalBlock * 2),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: blue),
                    border: InputBorder.none,
                    labelText: "Password",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: verticalBlock, horizontal: horizontalBlock * 5)),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) => value != null && value.length < 6 ? 'Enter in. 6 characters' : null),
              ),
            ),
            SizedBox(
              height: verticalBlock * 2.5,
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [containerShadow],
                color: Colors.white,
              ),
              margin: EdgeInsets.symmetric(horizontal: horizontalBlock * 10),
              child: TextFormField(
                style: TextStyle(color: blue, fontSize: verticalBlock * 2),
                decoration: InputDecoration(
                    labelStyle: TextStyle(color: blue),
                    border: InputBorder.none,
                    labelText: "Confirm Password",
                    contentPadding:
                        EdgeInsets.symmetric(vertical: verticalBlock, horizontal: horizontalBlock * 5)),
                obscureText: true,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: ((value) =>
                    value != passwordController.text.trim() ? 'Passwords do not match' : null),
              ),
            ),
            SizedBox(height: verticalBlock),
            pass == false
                ? Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: horizontalBlock * 10),
                      child: Text('This email adress is already in use by another account',
                          style: TextStyle(color: Colors.red, fontSize: verticalBlock * 2)),
                    ),
                  )
                : Text(''),
            SizedBox(height: verticalBlock * 3),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: horizontalBlock * 12, vertical: verticalBlock * 2),
              ),
              onPressed: signUp,
              child: Text(
                'Sign up',
                style: TextStyle(color: blue, fontWeight: FontWeight.bold, fontSize: verticalBlock * 2.3),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: verticalBlock * 3, bottom: verticalBlock),
              child: RichText(
                  text: TextSpan(
                      text: "Already have an accout?  ",
                      style: TextStyle(color: Colors.white, fontSize: verticalBlock * 1.8),
                      children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignIn,
                        text: "Sign in",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.white,
                            fontSize: verticalBlock * 2))
                  ])),
            ),
            Image.asset(
              'assets/images/signup_bottom.png',
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(), password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      signUpError();
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
