import 'package:flutter/material.dart';

import '../styles/colors.dart';

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
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: Image.network(
            alignment: Alignment.topLeft,
            width: 129,
            height: 199,
            widget.img,
          ),
        ),
        Positioned(
          left: -4,
          child: InkWell(
            onTap: () {},
            child: ImageIcon(
              color: GREY_COLOR,
              AssetImage('lib/assets/Photos/bookmark.png'),
              size: 34,
            ),
          ),
        ),
      ],
    );
  }
}
