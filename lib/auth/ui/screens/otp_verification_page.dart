import 'package:flutter/material.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OtpVerificationPage'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OtpVerificationPage is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
