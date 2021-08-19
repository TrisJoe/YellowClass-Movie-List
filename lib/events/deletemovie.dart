import 'movieevent.dart';

class DeleteMovie extends MovieEvent {
  late int movieIndex;

  DeleteMovie(int index) {
    movieIndex = index;
  }
}
