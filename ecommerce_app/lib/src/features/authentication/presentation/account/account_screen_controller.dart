// this class is similar to the vm class in MVVM arch
// it will handle the different states like data, loading, and error 
import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateNotifier is an alternative to ValueNotifier in the Flutter SDK
// ideal for managing immutable state that widgets can listen to
class AccountScreenController extends StateNotifier<AsyncValue<void>>{
  // StateNotifier always needs an initial value
  // it needs to be set with the constructor using super()
  // data(null) means "not loading"
 AccountScreenController({required this.authRepository})
      : super(const AsyncValue<void>.data(null));
  final FakeAuthRepository authRepository;
 
  Future<bool> signOut() async {
    try {
      state = const AsyncValue<void>.loading();
      await authRepository.signOut();
      state = const AsyncValue<void>.data(null);
      return true;
    } catch (e, stackTrace) {
      state = AsyncValue<void>.error(e, stackTrace);
      return false;
    }
  }

}

final accountScreenControllerProvider = StateNotifierProvider.autoDispose<
    AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(
    authRepository: authRepository,
  );
});