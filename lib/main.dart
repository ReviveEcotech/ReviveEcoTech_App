import 'package:flutter/material.dart';
import 'package:revive_eco_tech_app/launch_page.dart';


void main() async {
  runApp( MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'RedHatDisplay',
    ),
    home: launch_page(),
  )
  );
}