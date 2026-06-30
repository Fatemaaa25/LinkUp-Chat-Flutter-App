import 'package:flutter/material.dart';

const kSendButtonTextStyle = TextStyle(
  color: Color(0xFF005B5F),
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  hintStyle: TextStyle(color: Colors.black),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Color(0xFF005B5F), width: 2.0),
  ),
);

const kTextFieldDecoration=InputDecoration(
  filled: true,
  fillColor: Colors.white,
  hintText: 'Enter your email',
  hintStyle: TextStyle(color: Colors.black),
  contentPadding: EdgeInsets.symmetric(
    vertical: 10.0,
    horizontal: 20.0,
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF005B5F),
      width: 1.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(0xFF003E5F),
      width: 2.0,
    ),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);

const kBoxDecoration=BoxDecoration(
  image: DecorationImage(
    image: AssetImage('images/bg.jpg'),
    fit: BoxFit.cover,
  ),
);
