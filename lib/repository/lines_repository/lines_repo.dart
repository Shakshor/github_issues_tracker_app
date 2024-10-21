import 'dart:convert';
import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final linesRepoProvider = Provider((ref){
  return LinesRepo();
});

class LinesRepo{
  final String apiUrl = 'https://poetrydb.org/title/Ozymandias/lines.json';

  Future<List<dynamic>> fetchLines() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      log('inside_lines_repo_data: ${data.first['lines']}');
      return data.first['lines'];
    } else {
      throw Exception('Failed to load lines');
    }
  }
}