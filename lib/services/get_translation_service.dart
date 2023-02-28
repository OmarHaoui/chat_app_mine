import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_chat_app/models/translated_text_model.dart';

class GetTranslationService {
  dynamic get(String origin, String from, String to) async {
    String baseUrl = "https://api.mymemory.translated.net";
    Uri uri = Uri.parse("$baseUrl/get?q=$origin!&langpair=$from|$to");

    http.Response response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return TranslatedText.fromJson(data);
    } else {
      throw new Exception(
          "there is a problem with status code ${response.statusCode}");
    }
  }
}
