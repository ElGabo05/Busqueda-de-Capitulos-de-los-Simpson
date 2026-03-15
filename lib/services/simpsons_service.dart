import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/episode.dart';

class SimpsonsService {
  static const String _baseUrl = 'https://thesimpsonsapi.com/api/episodes';

  Future<Episode?> getEpisodeById(int id) async {
    final url = Uri.parse('$_baseUrl/$id');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedData = json.decode(response.body);
        return Episode.fromJson(decodedData);
      }
      return null;
    } catch (e) {
      print('Error al obtener el capítulo: $e');
      return null;
    }
  }
}
