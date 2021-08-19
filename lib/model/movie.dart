import 'package:yellowclass/database/moviedatabase.dart';

class Movie {
  int? id;
  String? name;
  String? director;
  String? photo_name;
  Movie({this.id, this.name, this.director, this.photo_name});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_NAME: name,
      DatabaseProvider.COLUMN_DIRECTOR: director,
    };
    if (id != null) {
      map[DatabaseProvider.COLUMN_ID] = id;
    }
    return map;
  }

  Movie.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseProvider.COLUMN_ID];
    name = map[DatabaseProvider.COLUMN_NAME];
    director = map[DatabaseProvider.COLUMN_DIRECTOR];
  }
}
