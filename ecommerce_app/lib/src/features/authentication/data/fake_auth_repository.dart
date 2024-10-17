// ignore: dangling_library_doc_comments
import 'package:ecommerce_app/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// This class will be used for Auth services. 
/// It will be used to read data

class FakeAuthRepository {

  Stream<AppUser?> authStateChanges() => Stream.value(null);

  AppUser? get currentUser => null;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    
  }

   Future<void> createUserWithEmailAndPassword(String email, String password) async {
    
  }

   Future<void> signOut() async {

   }
}

/// Provider to access the repository
/// 

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  return FakeAuthRepository();
});
 
final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
});