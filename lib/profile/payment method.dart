import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white24,
          centerTitle: true,
          title: const Text(' Payment Method',
              style: TextStyle(color: Colors.black)),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.black,
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Lottie.asset('assets/payment_on_recieve.json'),
              const SizedBox(
                width: 20.0,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Payment after receipt',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w800,
                    color: Colors.black),
              ),
            ],
          ),
        ));
  }
}
