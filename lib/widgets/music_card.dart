import 'package:flutter/material.dart';

Widget musicCard(String name, Function() onTap) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: Colors.grey.shade300,
        width: 1,
      ),
    ),
    elevation: 3,
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue.shade100,
        child: Icon(
          Icons.music_note,
          color: Colors.blue.shade700,
        ),
      ),
      title: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
      subtitle: Text(
        'Tap to play music',
        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
      ),
      trailing: Icon(
        Icons.play_arrow,
        color: Colors.blue.shade700,
      ),
      onTap: onTap,
    ),
  );
}
