import 'dart:async';
import 'dart:convert';
import 'dart:math';

import '../widgets/listen_button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../utils/color_scheme.dart';

import 'package:google_fonts/google_fonts.dart';
import '../widgets/green_button.dart';
import '../../widgets/my_progress_indicator.dart';

import 'reading_page.dart';

class BibleReadingPlan extends StatelessWidget {
  final void Function(String url) urlCallback;
  const BibleReadingPlan({
    required this.numRefocuses,
    required this.urlCallback,
  });

  final int numRefocuses;

  @override
  Widget build(BuildContext context) => FutureBuilder<List<BrcDay>>(
      future: _brcDaysFuture,
      builder: (BuildContext context, AsyncSnapshot<List<BrcDay>> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
        }

        return snapshot.hasData
            ? BrcDaysList(
                brcDays: snapshot.data!,
                numRefocuses: numRefocuses,
                urlCallback: urlCallback,
                key: UniqueKey(),
              )
            : const MyProgressIndicator();
      });
}

Future<List<BrcDay>> _brcDaysFuture = _fetchBrcDays(http.Client());

Future<List<BrcDay>> _fetchBrcDays(http.Client client) async {
  final Response response =
      await client.get(Uri.parse('https://ctk-app.jcb3.de/brc.json'));

  // Use the compute function to run parseBrcDays in a separate isolate
  return compute(parseBrcDays, response.body);
}

// A function that will convert a response body into a List<BrcDay>
List<BrcDay> parseBrcDays(String responseBody) {
  final List<dynamic> parsed = json.decode(responseBody) as List<dynamic>;

  return parsed
      .map<BrcDay>(
          (dynamic json) => BrcDay.fromJson(json as Map<String, dynamic>))
      .toList();
}

class BrcDay {
  BrcDay(
      {required this.date,
      required this.passage,
      required this.friendlyPassage});

  factory BrcDay.fromJson(Map<String, dynamic> json) {
    return BrcDay(
        date: DateTime.parse(json['date'].toString()),
        passage: json['passage'] as String,
        friendlyPassage: json['friendlyPassage'] as String);
  }

  final DateTime date;
  final String passage;
  final String friendlyPassage;
}

class BrcDaysList extends StatefulWidget {
  final void Function(String url) urlCallback;
  const BrcDaysList({
    required Key key,
    required this.brcDays,
    required this.numRefocuses,
    required this.urlCallback,
  }) : super(key: key);
  final List<BrcDay> brcDays;
  final int numRefocuses;

  @override
  BrcDaysListState createState() => BrcDaysListState();
}

class BrcDaysListState extends State<BrcDaysList> {
  BrcDaysListState();
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();

    _jumpToToday();
  }

  @override
  void didUpdateWidget(covariant BrcDaysList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.numRefocuses != widget.numRefocuses) {
      _jumpToToday();
    }
  }

  void _jumpToToday() {
    final DateTime now = DateTime.now();
    final DateTime today = DateTime(now.year, now.month, now.day);

    // Get index of current day, or 0 if no match
    final int index = max(
        widget.brcDays.indexWhere((BrcDay element) => element.date == today),
        0);

    Future<void>.delayed(const Duration(milliseconds: 0),
        () => itemScrollController.jumpTo(index: index));
  }

  @override
  Widget build(BuildContext context) => ScrollablePositionedList.builder(
        itemCount: widget.brcDays.length,
        itemBuilder: (BuildContext context, int index) =>
            buildBrcDay(context, index),
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
      );

  Widget buildBrcDay(BuildContext context, int index) {
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
              const SizedBox(
                width: 11.0,
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      DateFormat('EEEE, MMMM d, y')
                          .format(widget.brcDays[index].date)
                          .toString(),
                      maxLines: 1,
                      style: GoogleFonts.nunito(
                          color: BODY2,
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold)),
                  Text(widget.brcDays[index].friendlyPassage,
                      maxLines: 1,
                      style: GoogleFonts.nunito(
                          color: GREY3,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w400)),
                ],
              )),
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
                              ReadingPage(widget.brcDays[index].passage));
                        },
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: ListenButtonWidget(
                          title: widget.brcDays[index].passage.toString(),
                          description: 'Welcome to the Feast',
                          urlCallback: widget.urlCallback,
                          url: 'https://ctk-app.jcb3.de/listen/' +
                              Uri.encodeComponent(widget.brcDays[index].passage
                                      .toString()
                                      .trim() +
                                  '.mp3'))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
