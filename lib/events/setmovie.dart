import 'package:yellowclass/model/movie.dart';
import 'movieevent.dart';

class SetMovies extends MovieEvent {
  List<Movie>? movieList;

  SetMovies(List<Movie> movies) {
    movieList = movies;
  }
}
