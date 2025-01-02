import 'package:flutter/material.dart';

Widget customButton(Function() ontap, String label) {
  return ElevatedButton(
    onPressed: ontap,
    style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        backgroundColor: Colors.blue[400],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        fixedSize: const Size(320, double.infinity)),
    child: Text(
      label,
      style: const TextStyle(color: Colors.white, fontSize: 20),
      textAlign: TextAlign.center,
    ),
  );
}
