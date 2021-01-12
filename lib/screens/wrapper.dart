import 'package:brew_crew/screens/authenticate/authenticate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/cupertino.dart';
import "package:provider/provider.dart";
import "package:brew_crew/models/user.dart";

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);
    DatabaseService _brews = DatabaseService();
    if (user != null) {
      _brews = DatabaseService(uid: user.uid);
    }

    //return eiter Home or Authenticate Widget;
    if (user == null) {
      return Authenticate();
    } else {
      return StreamProvider.value(value: _brews.brews, child: Home());
    }
  }
}
