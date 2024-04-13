import 'package:flutter/material.dart';

class Images extends StatelessWidget {
  const Images({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset('lib/woman.jpg'),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Honey_Badger.jpg/1920px-Honey_Badger.jpg',
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}
