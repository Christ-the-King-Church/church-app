import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/color_scheme.dart';
import '../../widgets/my_progress_indicator.dart';
import 'note_entity.dart';
import 'note_item.dart';
import 'note_service.dart';

class NoteList extends StatefulWidget {
  const NoteList({
    Key key,
  }) : super(key: key);
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  _NoteListState();
  bool isLoad = false;
  List<NoteEntity> list = [];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    _initNoteList();
  }

  @override
  Widget build(BuildContext context) => Container(
      color: MAIN1, child: isLoad ? _content() : const MyProgressIndicator());

  Widget _content() {
    return ScrollablePositionedList.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return NoteItem(
          key: UniqueKey(),
          note: list[index],
        );
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );
  }

  void _initNoteList() async {
    var _list = await NoteService.getNoteList();

    setState(() {
      list = _list;
      isLoad = true;
    });
  }
}
