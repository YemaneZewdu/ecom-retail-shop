// this class will be used to handle saving the auth changes because 
//stream controller doesn't have this feature
// it will give us a stream 
// it's like a wrapper over BehaviorSubject
import 'package:rxdart/subjects.dart';
/// An in-memory store backed by BehaviorSubject that can be used to
/// store the data for all the fake repositories in the app.
class InMemoryStore<T> {
  InMemoryStore(T initial) : _subject = BehaviorSubject<T>.seeded(initial);
 
  /// The BehaviorSubject that holds the data
  final BehaviorSubject<T> _subject;
 
  /// The output stream that can be used to listen to the data
  Stream<T> get stream => _subject.stream;
 
  /// A synchronous getter for the current value
  T get value => _subject.value;
 
  /// A setter for updating the value
  set value(T value) => _subject.add(value);
 
  /// Don't forget to call this when done
  void close() => _subject.close();
}
