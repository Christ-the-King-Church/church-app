import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../utils/color_scheme.dart';
import '../../widgets/my_progress_indicator.dart';
import 'sermon_entity.dart';
import 'sermon_item.dart';
import 'sermon_service.dart';

class SermonList extends StatefulWidget {
  final void Function(String url) urlCallback;

  const SermonList({
    required Key key,
    required this.urlCallback,
  }) : super(key: key);
  @override
  _SermonListState createState() => _SermonListState();
}

class _SermonListState extends State<SermonList> {
  _SermonListState();
  bool isLoad = false;
  List<SermonEntity> list = [];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  void initState() {
    super.initState();
    _initSermonList();
  }

  @override
  Widget build(BuildContext context) => Container(
      color: MAIN1, child: isLoad ? _content() : const MyProgressIndicator());

  Widget _content() {
    return ScrollablePositionedList.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return SermonItem(
          key: UniqueKey(),
          sermon: list[index],
          urlCallback: widget.urlCallback,
        );
      },
      itemScrollController: itemScrollController,
      itemPositionsListener: itemPositionsListener,
    );
  }

  void _initSermonList() async {
    var _list = await SermonService.getSermonList();

    setState(() {
      list = _list;
      isLoad = true;
    });
  }
}
