import 'package:firebase_auth/firebase_auth.dart';

class PhoneAuthRepository {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(PhoneAuthCredential) verificationCompleted,
    required Function(FirebaseAuthException) verificationFailed,
    required Function(String, int?) codeSent,
    required Function(String) codeAutoRetrievalTimeout,
    int? resendToken,
  }) async {
    await auth.verifyPhoneNumber(
      timeout: const Duration(seconds: 120),
      phoneNumber: phoneNumber,
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
      forceResendingToken: resendToken,
    );
  }
}
