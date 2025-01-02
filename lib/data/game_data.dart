import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:internship_project/data/model/game_model.dart';

String API_KEY = '3d937606929141e9937e19bc2bdc6975';

Future<List<Game>> fetchGameList() async {
  String url =
      'https://api.rawg.io/api/games?key=$API_KEY&dates=2023-01-01,2024-01-01&ordering=-added&page_size=30';
  try {
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List games = json.decode(response.body)['results'];

      return games.map((game) {
        return Game(
          id: game['id'].toString(),
          name: game['name'],
          released: game['released'],
          backgroundImage: game['background_image'],
          rating: game['rating'].toString(),
          ratingCount: game['ratings_count'],
          // min_req: game['results']['platforms'][0]['requirements_en'] ??
          //     'No requirements',
          // recommended_req: game['results']['platforms'][0]['requirements_en'] ??
          //     'No requirements',
          // publisher: game['results']['publishers'][0]['name'] ?? 'No publisher',
          // description: game['results']['description_raw'] ?? 'No description',
          publisher: '',
          description: '',
        );
      }).toList();
    } else {
      print("error fyftf : ${response.statusCode}");
      throw Exception('Failed to load games');
    }
  } catch (e) {
    print("error : $e");
    throw Exception('Failed to load games');
  }
}

Future<Game> fetchGameDetails(String gameId) async {
  String url = 'https://api.rawg.io/api/games/$gameId?key=$API_KEY';
  try {
    var response =
        await http.get(Uri.parse(url)).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      final game = json.decode(response.body);
      return Game(
        id: game['id'].toString(),
        name: game['name'],
        released: game['released'],
        backgroundImage: game['background_image'],
        rating: game['rating'].toString(),
        ratingCount: game['ratings_count'],
        publisher: game['publishers'][0]['name'],
        description: game['description_raw'],
      );
    } else {
      print("error : ${response.statusCode}");
      throw Exception('Failed to load game details');
    }
  } catch (e) {
    print("error : $e");
    throw Exception('Failed to load game details');
  }
}
