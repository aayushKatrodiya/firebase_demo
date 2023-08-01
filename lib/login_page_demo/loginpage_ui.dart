import 'package:flutter/material.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  State<LoginPageUi> createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {
  final _emaiController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emaiController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
      body: Column(
        children: [
          const Icon(
            Icons.android,
            size: 50,
            color: Colors.black,
          ),
          const Text(
            "MY APP!!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Text(
            "WELCOME TO FLUTTER APPLICATIN!!",
            style: TextStyle(
              fontSize: 25,
              color: Color.fromARGB(255, 52, 52, 52),
            ),
          ),
          TextFormField(
            controller: _emaiController,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(width: 3, color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide()),
            ),
          ),
          TextFormField(),
        ],
      ),
    );
  }
}
