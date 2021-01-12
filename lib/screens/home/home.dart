import 'package:brew_crew/models/user.dart';
import 'package:brew_crew/screens/home/brewList.dart';
import 'package:brew_crew/screens/home/setting_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    final _brews = Provider.of<QuerySnapshot>(context);
    Map userRef;
    for (int i = 0; i < _brews.docs.length; i++) {
      if (_brews.docs[i].id == user.uid) {
        userRef = _brews.docs[i].data();
      }
    }

    print("${userRef} ok");
    void _showSettingPanel(BuildContext context) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingFroms(
                currentName: userRef["name"],
                currentStrength: userRef["strength"],
                currentSugars: userRef["sugars"],
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text("Brew Crew"),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("Logout"),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            icon: Icon(Icons.settings),
            label: Text("Setting"),
            onPressed: () => _showSettingPanel(context),
          ),
        ],
      ),
      body: BrewList(),
    );
  }
}
