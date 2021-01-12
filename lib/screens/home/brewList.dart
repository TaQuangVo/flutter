import 'package:brew_crew/screens/home/BrewTile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:provider/provider.dart";

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final _brews = Provider.of<QuerySnapshot>(context);

    return ListView.builder(
      itemCount: _brews.docs.length,
      itemBuilder: (context, index) {
        return BrewTile(brew: _brews.docs[index]);
      },
    );
  }
}
