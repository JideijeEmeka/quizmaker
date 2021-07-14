import 'dart:ui';

import 'package:flutter/material.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: 200,
              width: 200,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage("lib/images/no-internet.jpg"),
              ))),
          Text(
            "No Internet Connection",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              "You are not Connected to the internet. Make sure your Wi-fi is on.",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
