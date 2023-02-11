import 'package:flutter/material.dart';

import '../styles/colors.dart';

Icon WishList = Icon(
  Icons.bookmark_outline,
  color: GREY_COLOR,
  size: 40,
);

class Film_Item extends StatefulWidget {
  String img;
  Film_Item(this.img);

  @override
  State<Film_Item> createState() => _Film_ItemState();
}

class _Film_ItemState extends State<Film_Item> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Image.network(
          width: 129,
          height: 199,
          widget.img,
        ),
        Container(
          padding: const EdgeInsets.all(0.0),
          width: 30.0, // you can adjust the width as you need
          child: Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {},
              child: WishList,
            ),
          ),
        ),
      ],
    );
  }
}
