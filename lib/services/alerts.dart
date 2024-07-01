import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AlertService {
  // success alert
  void successAlert({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Success: $msg',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
    );
  }

  // error alert
  void errorAlert({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $msg',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  // warning alert
  void warningAlert({required BuildContext context, required String msg}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Warning: $msg'),
        backgroundColor: Colors.yellow,
      ),
    );
  }
}
