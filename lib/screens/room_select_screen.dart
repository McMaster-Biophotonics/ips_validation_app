import 'package:flutter/material.dart';
import 'package:ips_validation_app/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;

class RoomSelectScreen extends StatefulWidget {
  static String id = 'roomSelectScreen';
  String expName;
  String expNumber;
  RoomSelectScreen({this.expName, this.expNumber});
  @override
  _RoomSelectScreenState createState() => _RoomSelectScreenState();
}

enum SingingCharacter { bedroom, kitchen, livingRoom, washroom, hallway }

class _RoomSelectScreenState extends State<RoomSelectScreen> {
  SingingCharacter _character = SingingCharacter.bedroom;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hero(tag: 'logo', child: Container(
              child: Image.asset('images/smarthomeIcon5.png'),
              width: 300,
            ),),
            TypewriterAnimatedTextKit(duration: Duration(seconds: 5), isRepeatingAnimation: false, text: ['Please Select Your Location as You Change Rooms'], textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
            SizedBox(height: 20,),
            buildListTile('Kitchen',  Image.asset('images/kitchen2.png'), SingingCharacter.kitchen),
            buildListTile('Bedroom',  Image.asset('images/bedroom.png'), SingingCharacter.bedroom),
            buildListTile('Living Room',  Image.asset('images/livingroom.png'), SingingCharacter.livingRoom),
            buildListTile('Washroom',  Image.asset('images/washroom.png'), SingingCharacter.washroom),
            buildListTile('Hallway',  Image.asset('images/hallway.png'), SingingCharacter.hallway),
            SizedBox(height: 20),
            RoundedButton(
              title: 'Restart Experiment',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
    );
  }

  ListTile buildListTile(String room, Widget trailWidget, SingingCharacter roomValue) {
    return ListTile(
            title: Center(child: Text(room, style: TextStyle(fontSize: 30),)),
            leading: Radio(
              value: roomValue,
              groupValue: _character,
              onChanged: (value) async {
                setState(() {
                  _character = value;
                });
                int curTime = DateTime.now().millisecondsSinceEpoch;
                await _firestore.collection('IPSValidation/${widget.expName}/Experiment${widget.expNumber}').document(curTime.toString()).setData({
                  'Location': room,
                  'writeTime': curTime,
                });
              },
            ),
            trailing: trailWidget,
          );
  }
}
