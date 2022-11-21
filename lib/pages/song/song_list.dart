import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:google_fonts/google_fonts.dart';
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
  List<SongEntity> filteredList = [];
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initSongList();
  }

  @override
  Widget build(BuildContext context) => Container(
      color: MAIN1, child: isLoad ? _content() : const MyProgressIndicator());

  void filterSearchResults(String query) {
    if (query.isNotEmpty) {
      List<SongEntity> dummyListData = [];
      list.forEach((item) {
        if ((item.name.toLowerCase()).contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredList.clear();
        filteredList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredList.clear();
        filteredList.addAll(list);
      });
    }
  }

  Widget _content() {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: GoogleFonts.nunito(
                color: BODY2, fontSize: 18.0, fontWeight: FontWeight.bold),
            onChanged: (value) {
              filterSearchResults(value);
            },
            controller: editingController,
            decoration: InputDecoration(
                labelText: "Search",
                labelStyle: GoogleFonts.nunito(
                    color: LIGHT_GREY,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                hintText: "Search",
                hintStyle: GoogleFonts.nunito(
                    color: LIGHT_GREY,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
                prefixIcon: Icon(
                  Icons.search,
                  color: LIGHT_GREY,
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)))),
          ),
        ),
        Expanded(
          child: _list(),
        ),
      ],
    ));
  }

  Widget _list() {
    return ScrollablePositionedList.builder(
      itemCount: filteredList.length,
      itemBuilder: (context, index) {
        return SongItem(
          key: UniqueKey(),
          song: filteredList[index],
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
      filterSearchResults('');
    });
  }
}
