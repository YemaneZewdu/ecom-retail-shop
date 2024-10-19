// ignore: dangling_library_doc_comments
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce_app/src/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This class will be used for Auth services.
/// It will be used to read data

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;
 
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }
 
  Future<void> createUserWithEmailAndPassword(
      String email, String password) async {
    if (currentUser == null) {
      _createNewUser(email);
    }
  }
 
  Future<void> signOut() async {
    _authState.value = null;
  }
 
  void _createNewUser(String email) {
    // note: the uid could be any unique string. Here we simply reverse the email.
    _authState.value =
        AppUser(uid: email.split('').reversed.join(), email: email);
  }
 
 // just creating this method is not enough so we have to use it 
 //below in the authRepositoryProvider
  void dispose() => _authState.close();
}
 
 // Provider to access the repository
final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
});
 
final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});