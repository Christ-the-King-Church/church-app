import 'package:dart_date/src/dart_date.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/color_scheme.dart';

class SongPage extends MaterialPageRoute<void> {
  SongPage({this.title, this.song})
      : super(builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                actions: const <Widget>[],
                iconTheme: const IconThemeData(
                  color: GREY3, //change your color here
                ),
                title: Text(title,
                    maxLines: 1,
                    style: GoogleFonts.nunito(
                        color: BODY2,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold)),
                backgroundColor: MAIN1,
              ),
              body: SingleChildScrollView(
                  child: Container(
                      decoration: const BoxDecoration(color: MAIN1),
                      child: Center(
                          child: Container(
                              color: MAIN1,
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 10.0,
                                ),
                                child: Text(song,
                                    style: GoogleFonts.nunito(
                                        color: GREY3,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w400)),
                              ))))));
        });
  final String title;
  final String song;
}
