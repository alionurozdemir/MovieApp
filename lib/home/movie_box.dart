import 'package:flutter/material.dart';

class MovieBox extends StatelessWidget {
  String title = "";
  String image = "";
  MovieBox({
    Key? key,
    required this.title,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            title: Text(title),
          ),
          Expanded(
            child: Image.network(
              image,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
