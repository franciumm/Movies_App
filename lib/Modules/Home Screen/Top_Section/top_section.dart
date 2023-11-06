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
            height: MediaQuery.of(context).size.height* (240/870),
            child: Image.network(
                fit: BoxFit.fill,
                'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg'),
          ),
          const Icon(
            Icons.slow_motion_video_rounded,
            color: Colors.white,
            size: 50,
          ),
        ]),
        Padding(
          padding:  EdgeInsets.only(left: 15.0, top: MediaQuery.of(context).size.height* (5/29)),
          child: Row(
            children: [
              Film_Item( 'Avengers End Game','',4,false,
                  MediaQuery.of(context).size.width* (129/412),MediaQuery.of(context).size.height* (199/870), 'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg',false),
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height* (1/15),left: MediaQuery.of(context).size.width* (1/7)),
                child: Column(
                  children: [
                   const  Text(
                      'Puss in Boots',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    Text(
                      '2022 1h 58m',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimaryContainer),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
