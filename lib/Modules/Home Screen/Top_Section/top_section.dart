import 'package:flutter/material.dart';

import '../../../shared/components/film_item.dart';

class TopSection extends StatelessWidget {
  const TopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(alignment: Alignment.center, children: [
          Container(
            width: double.infinity,
            height: 200,
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
          padding: const EdgeInsets.only(left: 15.0, top: 85),
          child: Row(
            children: [
              Film_Item(
                  'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg'),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 95.0, left: 20),
                    child: Text(
                      'Puss in Boots',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0),
                    child: Text(
                      '2022 1h 58m',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
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
