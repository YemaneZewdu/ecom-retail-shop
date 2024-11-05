import 'package:ecommerce_app/src/features/authentication/data/fake_auth_repository.dart';
import 'package:ecommerce_app/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  // whenever extending StateNotifier, we will have to pass an initial value
  EmailPasswordSignInController({
    required EmailPasswordSignInFormType formType,
    required this.authRepository,
  }) : super(EmailPasswordSignInState(formType: formType));

  final FakeAuthRepository authRepository;

  Future<bool> submit(String email, String password) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => _autheticate(email, password));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> _autheticate(String email, String password) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(email, password);
    }
  }

  void updateFormType(EmailPasswordSignInFormType formType){
    state = state.copyWith(formType: formType);
  }
}
/// when using family, we need to add additional type annotation
/// in this case it's EmailPasswordSignInFormType
final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>((ref, formType) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailPasswordSignInController(
    authRepository: authRepository,
    formType: formType,
  );
});