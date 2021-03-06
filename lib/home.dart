import 'package:flock_out/stage.dart';
import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flock Out",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) {
                return Stage();
              }),
            );
          },
          child: Text("start"),
        ),
      ),
    );
  }
}
