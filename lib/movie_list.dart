import 'package:yellowclass/movie_form.dart';
import 'package:yellowclass/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass/events/deletemovie.dart';
import 'package:yellowclass/events/setmovie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/movie_bloc.dart';
import 'database/moviedatabase.dart';

class MovieList extends StatefulWidget {
  const MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, style: BorderStyle.none),
      color: Colors.cyan[200],
    );
  }

  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getMovies().then(
      (movieList) {
        BlocProvider.of<MovieBloc>(context).add(SetMovies(movieList));
      },
    );
  }

  showMovieDialog(BuildContext context, Movie movie, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Title ${movie.name}"),
        content: Text("ID ${movie.id}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MovieForm(movie: movie, movieIndex: index),
              ),
            ),
            child: const Text("Update"),
          ),
          FlatButton(
            onPressed: () => DatabaseProvider.db.delete(movie.id).then((_) {
              BlocProvider.of<MovieBloc>(context).add(
                DeleteMovie(index),
              );
              Navigator.pop(context);
            }),
            child: const Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("Building entire movie list scaffold");
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOVIES LIST"),
        backgroundColor: Colors.cyan[400],
        centerTitle: true,
        elevation: 1.0,
      ),
      body: Container(
        decoration: myBoxDecoration(),
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<MovieBloc, List<Movie>>(
          builder: (context, movieList) {
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                print("movieList: $movieList");

                Movie movie = movieList[index];
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text("Title: ${movie.name}\n",
                        style: const TextStyle(fontSize: 26)),
                    subtitle: Text(
                      "Director: ${movie.director}\n",
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () => showMovieDialog(context, movie, index),
                  ),
                );
              },
              itemCount: movieList.length,
            );
          },
          listener: (BuildContext context, movieList) {},
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const MovieForm()),
        ),
      ),
    );
  }
}
