class TranslatedText {
  String after;
  String before;
  TranslatedText({
    required this.after,
    required this.before,
  });

  factory TranslatedText.fromJson(jsonData) {
    return new TranslatedText(
        after: jsonData["matches"][0]["translation"],
        before: jsonData["responseData"]["translatedText"]);
  }
}
