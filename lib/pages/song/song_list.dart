import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/color_scheme.dart';
import '../../widgets/my_progress_indicator.dart';
import 'song_entity.dart';
import 'song_item.dart';
import 'song_service.dart';

class SongList extends StatefulWidget {
  const SongList({
    Key key,
  }) : super(key: key);
  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  _SongListState();
  bool isLoad = false;
  List<SongEntity> list = [];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  @override
  Widget build(BuildContext context) => Container(
      color: MAIN1, child: isLoad ? _content() : const MyProgressIndicator());

  Widget _content() {
    return ScrollablePositionedList.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return SongItem(
          key: UniqueKey(),
          song: list[index],
        );
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );
  }

  void _initSongList() async {
    var _list = await SongService.getSongList();

    setState(() {
      list = _list;
      isLoad = true;
    });
  }
}
