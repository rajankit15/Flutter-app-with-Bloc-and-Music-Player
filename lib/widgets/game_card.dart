import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:internship_project/data/model/game_model.dart';

Widget gameCard(Game g) {
  return Container(
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 221, 234, 240),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(
        color: Color.fromARGB(255, 237, 249, 255),
        width: 2,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          child: CachedNetworkImage(
            imageUrl: g.backgroundImage,
            errorWidget: (context, url, error) => Icon(Icons.error),
            placeholder: (context, url) => Center(
              child: Text('Loading...'),
            ),
            fit: BoxFit.cover,
            height: 100,
            width: double.infinity,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                g.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                'Released: ${g.released}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Rating : ${g.rating}",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
