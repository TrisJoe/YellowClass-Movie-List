import 'package:yellowclass/model/movie.dart';
import 'package:yellowclass/events/addmovie.dart';
import 'package:yellowclass/events/deletemovie.dart';
import 'package:yellowclass/events/movieevent.dart';
import 'package:yellowclass/events/setmovie.dart';
import 'package:yellowclass/events/updatemovie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieBloc extends Bloc<MovieEvent, List<Movie>> {
  MovieBloc(List<Movie> initialState) : super(initialState);
  @override
  Stream<List<Movie>> mapEventToState(MovieEvent event) async* {
    if (event is SetMovies) {
      yield event.movieList!;
    } else if (event is AddMovie) {
      List<Movie?> newState = List.from(state);
      if (event.newMovie != null) {
        newState.add(event.newMovie);
      }
      yield newState as List<Movie>;
    } else if (event is DeleteMovie) {
      List<Movie> newState = List.from(state);
      newState.removeAt(event.movieIndex);
      yield newState;
    } else if (event is UpdateMovie) {
      List<Movie?> newState = List.from(state);
      newState[event.movieIndex!] = event.newMovie;
      yield newState as List<Movie>;
    }
  }
}
