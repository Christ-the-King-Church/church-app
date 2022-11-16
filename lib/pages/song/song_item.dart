import 'package:flutter/material.dart';
import 'song_entity.dart';
import '../../utils/color_scheme.dart';

import 'package:google_fonts/google_fonts.dart';
import '../../widgets/listen_button_widget.dart';
import 'package:CtkChurchConnect/widgets/green_button.dart';
import 'song_page.dart';

class SongItem extends StatelessWidget {
  const SongItem({
    Key key,
    this.song,
  }) : super(key: key);

  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MAIN1,
      child: Card(
        color: MAIN1,
        child: Container(
          height: 100.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Container(
                      margin: const EdgeInsets.only(
                        left: 15.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(song.name,
                              maxLines: 1,
                              style: GoogleFonts.nunito(
                                  color: BODY2,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold)),
                          // Text(song.date,
                          //     maxLines: 1,
                          //     style: GoogleFonts.nunito(
                          //         color: GREY3,
                          //         fontSize: 16.0,
                          //         fontWeight: FontWeight.w400)),
                        ],
                      ))),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: GreenButton(
                        text: '',
                        icon: Icons.remove_red_eye,
                        onPressed: () {
                          Navigator.push(context,
                              SongPage(title: song.name, song: song.words));
                        },
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
