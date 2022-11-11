import 'song_entity.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class SongService {
  SongService();
  static Future<List<SongEntity>> getSongList() async {
    final response = await http.get(
        'https://api.airtable.com/v0/appm4vCSGVm07WENN/Songs?maxRecords=999&view=Grid%20view&fields%5B%5D=Name&fields%5B%5D=Words&api_key=keyivF3wiQDy6LK3z');

    if (response.statusCode == 200) {
      //var _decoded = [];
      dynamic parsedJson = jsonDecode(response.body);
      List<SongEntity> arr = [];

      List<dynamic> items = parsedJson['records'] as List<dynamic>;

      if (items.length > 0) {
        for (final dynamic item in items) {
          Map<String, dynamic> fields = item['fields'] as Map<String, dynamic>;

          if (fields.length > 0) {
            arr.add(SongEntity(
              name: fields['Name'].toString(),
              words: fields['Words'].toString(),
              date: DateFormat('EEEE, MMMM d, y')
                  .format(DateTime.parse(item['createdTime'].toString()))
                  .toString(),
            ));
          }
        }
      }
      return arr;
    } else {
      throw Exception('Failed to fetch Songs data');
    }
  }
}
