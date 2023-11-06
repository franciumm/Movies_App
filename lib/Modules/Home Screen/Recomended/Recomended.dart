import 'package:flutter/material.dart';
import 'package:movies/shared/components/film_item.dart';
import 'package:movies/shared/styles/colors.dart';




class recomended extends StatelessWidget {
  const recomended({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height:  MediaQuery.of(context).size.height * (257/870),
      decoration: BoxDecoration(color: GREY_COLOR),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Padding(
            padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height * (1/50), horizontal:  MediaQuery.of(context).size.height * (1/50)),
            child: const Text(
              'Recomended',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(

              itemBuilder: (context, index) => Padding(
                padding:EdgeInsets.only( left:  MediaQuery.of(context).size.height * (1/50)),
                child: Film_Item('Avengers End Game','2018 R 1h 59m',9, true,
                  MediaQuery.of(context).size.width* (96.87/412),MediaQuery.of(context).size.height* (127.87/870), 'https://media0004.elcinema.com/uploads/_315x420_b900b6d7169ab527ee0eaa45665743e50e0dfa408a1e679b49821357c6c78f6f.jpg',false),
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
