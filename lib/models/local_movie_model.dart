class LocalMovieModelFields {
  static final List<String> values = [id, name, image];

  static const String id = '_id';
  static const String name = 'name';
  static const String image = 'email';
}

class LocalMovieModel {
  final int? id;
  final String name;
  final String image;

  LocalMovieModel({
    this.id,
    required this.name,
    required this.image,
  });

  static LocalMovieModel fromJson(Map<String, dynamic> json) => LocalMovieModel(
        id: json[LocalMovieModelFields.id],
        name: json[LocalMovieModelFields.name],
        image: json[LocalMovieModelFields.image],
      );

  Map<String, dynamic> toJson() => {
        LocalMovieModelFields.id: id,
        LocalMovieModelFields.name: name,
        LocalMovieModelFields.image: image,
      };
}
