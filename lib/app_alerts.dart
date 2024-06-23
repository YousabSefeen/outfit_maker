import 'package:flutter/material.dart';

class AppAlerts {
  static customSnackBar({
    required BuildContext context,
    required String msg,
    bool? isSuccess=false,
  }) {
    SnackBar sB = SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor:isSuccess==true?Colors.green: Colors.red,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );

    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(sB);
  }
}
