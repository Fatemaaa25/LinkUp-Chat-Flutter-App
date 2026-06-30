import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

    // animation=ColorTween(begin: Colors.red,end: Colors.blue).animate(controller!);

    controller!.forward();
    controller!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller!.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: kBoxDecoration,
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      child: Image.asset('images/logo.png', height: 350),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -100),
                    child: AnimatedTextKit(
                      repeatForever: true,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          'LinkUp',
                          speed: Durations.short3,
                          textStyle: TextStyle(
                            color: Color(0xFF005B5F),
                            fontSize: 45,
                            fontWeight: FontWeight.w900,
                            height: 0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -70),
                    child: Text(
                      'CONNECT . CHAT . LINK UP',
                      style: TextStyle(
                        color: Color(0xFFD08C60),
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        height: 0.1,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.0),
              RoundedButton(colour:Color(0xFFD08C60),onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },text:'Login'),
              RoundedButton(colour:Color(0xFF005B5F),onPressed:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationScreen()),
                );
              },text:'Register')

            ],
          ),
        ),
      ),
    );
  }
}

