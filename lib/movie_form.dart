import 'package:yellowclass/model/movie.dart';
import 'package:flutter/material.dart';
import 'package:yellowclass/bloc/movie_bloc.dart';
import 'package:yellowclass/events/addmovie.dart';
import 'package:yellowclass/events/updatemovie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yellowclass/database/moviedatabase.dart';
import 'package:image_picker/image_picker.dart';

class MovieForm extends StatefulWidget {
  final Movie? movie;
  final int? movieIndex;

  // ignore: use_key_in_widget_constructors
  const MovieForm({this.movie, this.movieIndex});

  @override
  State<StatefulWidget> createState() {
    return MovieFormState();
  }
}

class MovieFormState extends State<MovieForm> {
  String? _name;
  String? _director;
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(width: 2.0, style: BorderStyle.none),
      color: Colors.cyan[200],
    );
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      initialValue: _name,
      decoration: const InputDecoration(labelText: 'Name'),
      maxLength: 100,
      style: const TextStyle(fontSize: 28),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Name is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildDirector() {
    return TextFormField(
      initialValue: _director,
      decoration: const InputDecoration(labelText: 'Director'),
      maxLength: 100,
      style: const TextStyle(fontSize: 28),
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Director is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _director = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.movie != null) {
      _name = widget.movie!.name;
      _director = widget.movie!.director;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.cyan[400],
          centerTitle: true,
          elevation: 1.0,
          title: const Text("Movie Form")),
      body: Container(
        decoration: myBoxDecoration(),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName(),
                _buildDirector(),
                const SizedBox(height: 16),
                const SizedBox(height: 20),
                widget.movie == null
                    ? RaisedButton(
                        child: const Text(
                          'Submit',
                          style: TextStyle(color: Colors.blue, fontSize: 16),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          _formKey.currentState!.save();

                          Movie movie = Movie(
                            name: _name,
                            director: _director,
                          );

                          DatabaseProvider.db.insert(movie).then(
                                (storedMovie) =>
                                    BlocProvider.of<MovieBloc>(context).add(
                                  AddMovie(storedMovie),
                                ),
                              );

                          Navigator.pop(context);
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RaisedButton(
                            child: const Text(
                              "Update",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 16),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                print("form");
                                return;
                              }

                              _formKey.currentState!.save();

                              Movie movie = Movie(
                                name: _name,
                                director: _director,
                              );

                              DatabaseProvider.db.update(widget.movie!).then(
                                    (storedMovie) =>
                                        BlocProvider.of<MovieBloc>(context).add(
                                      UpdateMovie(widget.movieIndex, movie),
                                    ),
                                  );

                              Navigator.pop(context);
                            },
                          ),
                          RaisedButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
