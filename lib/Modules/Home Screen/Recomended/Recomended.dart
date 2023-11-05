import 'package:flutter/material.dart';
import 'package:movies/shared/components/film_item.dart';
import 'package:movies/shared/styles/colors.dart';

class recomended extends StatelessWidget {
  const recomended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 187,
      decoration: BoxDecoration(color: GREY_COLOR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 20),
            child: Text(
              'Recomended',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(left: 20),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Film_Item(
                    'https://media0004.elcinema.com/uploads/_315x420_b900b6d7169ab527ee0eaa45665743e50e0dfa408a1e679b49821357c6c78f6f.jpg'),
              ),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
            ),
          )
        ],
      ),
    );
  }
}
