import 'package:compasia/Screens/Album/album.dart';
import 'package:http/http.dart' as http;

class AlbumRepo {
  static Future<List<AlbumList>> getAlbum() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
    );

    print(response.body);

    List<AlbumList> albumList = albumListFromJson(response.body);

    return albumList;

    // Question getquestion = questionFromJson(response.body)
  }

  static Future<void> submitAlbum(String title) async {
    final Map<String, String> map = {
      'title': title,
      'url': 'https://via.placeholder.com/600/92c952',
      'thumbnailUrl': 'https://via.placeholder.com/600/92c952',
    };

    final response = await http.post(
        Uri.parse('https://jsonplaceholder.typicode.com/photos'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: map);

    print(response.body);

    // Question getquestion = questionFromJson(response.body)
  }

  static Future<void> editAlbum(String title, String id) async {
    final Map<String, String> map = {
      'id': id,
      'title': title,
      'url': 'https://via.placeholder.com/600/92c952',
      'thumbnailUrl': 'https://via.placeholder.com/600/92c952',
    };

    final response = await http.put(
        Uri.parse('https://jsonplaceholder.typicode.com/photos'),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: map);

    print(response.body);

    // Question getquestion = questionFromJson(response.body)
  }

  static Future<void> deleteAlbum(String id) async {
    final Map<String, String> map = {
      'id': id,
    };

    final response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: map,
    );

    print(response.body);

    // Question getquestion = questionFromJson(response.body)
  }
}
