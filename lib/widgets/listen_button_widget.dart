import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';

class ListenButtonWidget extends StatefulWidget {
  const ListenButtonWidget({this.title, this.description, this.url});
  final String title;
  final String description;
  final String url;

  @override
  State<StatefulWidget> createState() =>
      _ListenButtonWidgetState();
}

class _ListenButtonWidgetState extends State<ListenButtonWidget> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[TextButton.icon(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor: MaterialStateProperty.all(Colors.blueGrey)),
        icon: const Icon(Icons.headset),
        label: const Text('LISTEN'),
        onPressed: () {
          if (AudioManager.instance.isPlaying) {
            AudioManager.instance.stop();
          } else {
            AudioManager.instance
                .start(widget.url, widget.title,
                    desc: widget.description,
                    cover: '')
                .then((String err) {
              print('Error' + err.toString());
            });
          }
          setState(() {
            playing = !playing;
          });
        })]);
  }
}
