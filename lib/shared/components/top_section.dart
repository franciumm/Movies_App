import 'package:flutter/material.dart';
import 'package:movies/shared/styles/my_theme.dart';

import '../styles/colors.dart';
import 'film_item.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: double.infinity,
            height: 289,
            child: Image.network(
                fit: BoxFit.fill,
                'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg'),
          ),
          Icon(
            Icons.slow_motion_video_rounded,
            color: Colors.white,
            size: 50,
          ),
        ]),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 190),
          child: Row(
            children: [
              Film_Item(
                  'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg'),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 90.0, left: 20),
                    child: Text(
                      'Puss in Boots',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Text(
                    '2022 1h 58m',
                    style: TextStyle(color: GREY_COLOR),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
