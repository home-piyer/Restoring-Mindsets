class Quote {
  final Map<String, dynamic> quoteText;
  Quote({
    required this.quoteText,
  });

  factory Quote.fromJson(List<dynamic> json) {
    return Quote(
      quoteText: json[0],
    );
  }
}
