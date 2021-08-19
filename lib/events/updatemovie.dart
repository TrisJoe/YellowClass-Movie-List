import 'package:yellowclass/model/movie.dart';
import 'movieevent.dart';

class UpdateMovie extends MovieEvent {
  Movie? newMovie;
  int? movieIndex;

  UpdateMovie(int? index, Movie movie) {
    newMovie = movie;
    movieIndex = index;
  }
}
