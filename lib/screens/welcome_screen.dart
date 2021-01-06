import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:ips_validation_app/constants.dart';
import 'package:ips_validation_app/components/rounded_button.dart';
import 'room_select_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;


class WelcomeScreen extends StatefulWidget {
  static String id = "welcomeScreen";
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {

  AnimationController controller;
  Animation animation;

  @override
  void initState(){
    super.initState();
    //controller = AnimationController(duration: Duration(seconds: 1));
  }


  String expName = '';
  String expNumber = '0';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Hero(tag: 'logo', child: Container(
              child: Image.asset('images/smarthomeIcon5.png'),
              width: 350,
            ),),
            SizedBox(height: 10),
            TypewriterAnimatedTextKit(text: ['IPS Validation'], textStyle: TextStyle(fontSize: 45, fontWeight: FontWeight.w900, textBaseline: TextBaseline.alphabetic),),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              onChanged: (value) {
                expName = value;
              },
              decoration:
              kTextFieldDecoration.copyWith(hintText: 'Enter Your Study ID'),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: false,
              textAlign: TextAlign.center,
              onChanged: (value) {
                expNumber = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter the Experiment Number'),
            ),
            SizedBox(
              height: 24.0,
            ),
            RoundedButton(
              title: 'Start Experiment',
              colour: Colors.lightBlueAccent,
              onPressed: () async {
                //await _firestore.collection('IPSValidation/$expName/Experiment$expNumber').document('ExperimentDetails').setData({
                //  'studyID': expName,
                //  'experimentNumber': expNumber,
                //});
                await _firestore.collection('IPSValidation').document(expName).setData({
                  'required': 'Ignore'
                });
                await Navigator.push(context, MaterialPageRoute(builder: (context) => RoomSelectScreen(expName: expName, expNumber: expNumber)));
              },
            ),
          ],
        ),
      ),
    );
  }
}
