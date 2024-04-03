import '../auth_cubit/auth_cubit.dart';
import 'custom_text_field.dart';
import 'package:flutter/material.dart';

class PhoneAuthForm extends StatelessWidget {
  const PhoneAuthForm({
    super.key,
    required this.cubit,
  });

  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Form(
        key: cubit.signInFormKey,
        child: Column(
          children: [
            const SizedBox(height: 100),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Phone Auth",
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 50),
            CustomTextFormField(
              controller: cubit.phoneController,
              labelText: "Enter Phone Number",
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return "This field is required";
                } else if (value!.length <= 10) {
                  return "Enter a valid number";
                } else if (!value.startsWith("+")) {
                  return 'Write the country code such as (+20)';
                } else if (value.contains(' ')) {
                  return "Please delete the spaces in the phone number";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                if (cubit.signInFormKey.currentState!.validate()) {
                  cubit.signInPhoneNumber(context);
                }
              },
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.blue),
              ),
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
