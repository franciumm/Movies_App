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
        InkWell(
          onTap: () {},
          child: ImageIcon(
            color: GREY_COLOR,
            AssetImage('lib/assets/Photos/bookmark.png'),
            size: 34,
          ),
        ),
      ],
    );
  }
}
