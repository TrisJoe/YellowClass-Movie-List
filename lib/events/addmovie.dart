import 'package:yellowclass/model/movie.dart';
import 'movieevent.dart';

class AddMovie extends MovieEvent {
  Movie? newMovie;

  AddMovie(Movie movie) {
    newMovie = movie;
  }
}
