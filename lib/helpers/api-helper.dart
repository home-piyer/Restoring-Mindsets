class JokesModel {
  final String joke;
  final String jokes;

  JokesModel({required this.joke, required this.jokes});

  factory JokesModel.fromJson(final json) {
    return JokesModel(joke: json["setup"], jokes: json["punchline"]);
  }
}
