import 'dart:async';

import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';

 class DataCon extends StatefulWidget {
 
   @override
   _DataConState createState() => _DataConState();
 }
 
 class _DataConState extends State<DataCon> {
  StreamSubscription<DataConnectionStatus> listener;
  var Internetstatus = "Unknown";

    @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }

    checkInternet() async {
    // Simple check to see if we have internet
    print("The statement 'this machine is connected to the Internet' is: ");
    print(await DataConnectionChecker().hasConnection);
    print("Current status: ${await DataConnectionChecker().connectionStatus}");
    print("Last results: ${DataConnectionChecker().lastTryResults}");

    // actively listen for status updates
    listener = DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          Internetstatus="Connectd TO THe Internet";
          print('Data connection is available.');
          setState(() {

          });
          break;
        case DataConnectionStatus.disconnected:
          Internetstatus="No Data Connection";
          print('You are disconnected from the internet.');
          setState(() {

          });
          break;
      }
    });

    // close listener after 30 seconds, so the program doesn't run forever
//    await Future.delayed(Duration(seconds: 30));
//    await listener.cancel();
    return await await DataConnectionChecker().connectionStatus;
  }


   @override
   Widget build(BuildContext context) {
     return Container(
       
     );
   }
 }