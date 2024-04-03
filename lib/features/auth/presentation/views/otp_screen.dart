import '../auth_cubit/auth_cubit.dart';
import '../widgets/custom_text_field.dart';
import '../../../home/presentation/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({
    super.key,
    required this.verificationId,
    required this.phoneNumber,
  });

  final String verificationId;
  final String phoneNumber;

  @override
  State<OtpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  Future<void> submitOTP(BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: _otpController.text.trim(),
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (Route<dynamic> route) => false);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: cubit.otpFormKey,
          child: Column(
            children: [
              const SizedBox(height: 100),
              const Text(
                "OTP Verfication",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                "code sent to ${widget.phoneNumber}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 35),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 70),
                child: CustomTextFormField(
                  labelText: "Enter the code",
                  controller: _otpController,
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (cubit.otpFormKey.currentState!.validate()) {
                    submitOTP(context);
                  }
                },
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(Colors.blue),
                ),
                child: const Text(
                  "Verify",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
