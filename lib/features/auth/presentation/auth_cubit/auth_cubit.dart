import 'auth_state.dart';
import '../views/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final GlobalKey<FormState> otpFormKey = GlobalKey();

  Future<void> signInPhoneNumber(BuildContext context) async {
    try {
      emit(SignInLoading());
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            if (kDebugMode) {
              print('The provided phone number is not valid.');
            }
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "The provided phone number is not valid.",
              ),
              backgroundColor: Colors.red,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                e.toString(),
              ),
              backgroundColor: Colors.red,
            ));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpScreen(
                verificationId: verificationId,
                phoneNumber: phoneController.text.trim(),
              ),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Code Sent successfully",
            ),
            backgroundColor: Colors.green,
          ));
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "Timed out waiting for SMS, try again",
            ),
            backgroundColor: Colors.red,
          ));
        },
      );
      emit(SignInSuccess());
    } catch (e) {
      emit(
        SignInFailure(errMessage: e.toString()),
      );
    }
  }
}
