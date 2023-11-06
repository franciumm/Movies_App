import 'package:flutter/material.dart';
import 'package:movies/shared/components/film_item.dart';
import 'package:movies/shared/styles/colors.dart';

class newrles extends StatelessWidget {
  const newrles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:  MediaQuery.of(context).size.height * (187/870),
      decoration: BoxDecoration(color: GREY_COLOR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(vertical:10, horizontal:  MediaQuery.of(context).size.height * (1/50)),
            child: const Text(
              'New Rleases',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding:EdgeInsets.only( left:  MediaQuery.of(context).size.height * (1/50)),
              itemBuilder: (context, index) => Padding(
                padding:  EdgeInsets.only(right:MediaQuery.of(context).size.height * (1/50)),
                child: Film_Item('','',4,
                  false,  MediaQuery.of(context).size.width* (96.87/412),MediaQuery.of(context).size.height* (127.87/870), 'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg',false),
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
