import 'package:flutter/material.dart';
import "package:brew_crew/shared/constants.dart";

class SettingFroms extends StatefulWidget {
  String currentName;
  String currentSugars;
  int currentStrength;
  SettingFroms({this.currentName, this.currentStrength, this.currentSugars});
  @override
  _SettingFromsState createState() => _SettingFromsState();
}

class _SettingFromsState extends State<SettingFroms> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ["0", "1", "2", "3", "4"];
  String _currentName;

  List<DropdownMenuItem> list;

  @override
  Widget build(BuildContext context) {
    list = sugars.map((sugar) {
      return DropdownMenuItem(
        child: Text("$sugar sugars"),
        value: sugar,
      );
    }).toList();
    print("runs");

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            "Update your Brew Settings.",
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            initialValue: widget.currentName,
            decoration: inputDectation,
            validator: (val) => val.isEmpty ? "Enter a name" : null,
            onChanged: (val) {
              setState(() => _currentName = val);
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          DropdownButtonFormField(
            value: widget.currentSugars,
            items: list,
            onChanged: (val) => setState(() => widget.currentSugars = val),
          ),
          SizedBox(
            height: 20.0,
          ),
          Slider(
            min: 100.0,
            max: 900.0,
            value: widget.currentStrength.toDouble(),
            divisions: 8,
            activeColor: Colors.brown[widget.currentStrength],
            inactiveColor: Colors.brown[widget.currentStrength],
            onChanged: (value) =>
                setState(() => widget.currentStrength = value.round()),
          ),
          SizedBox(
            height: 20.0,
          ),
          RaisedButton(
            color: Colors.pink[400],
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print(widget.currentSugars);
              print(widget.currentStrength);
              print(_currentName);
            },
          )
        ],
      ),
    );
  }
}
