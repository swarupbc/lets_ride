import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  static String id = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text(
            'Let\'s Ride',
            style: GoogleFonts.caveat(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
