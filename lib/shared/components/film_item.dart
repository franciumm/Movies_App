import 'package:flutter/material.dart';
import 'package:movies/shared/styles/colors.dart';
import 'package:movies/shared/styles/my_theme.dart';

class Film_Item extends StatefulWidget {
  String Title;
  String Time;
  double Rate;
  bool IsInfo;
  String img;
  bool wishlist;
  double width;
  double height;
  Film_Item(this.Title,this.Time,this.Rate, this.IsInfo ,this.width,this.height,this.img, this.wishlist);

  @override
  State<Film_Item> createState() => _Film_ItemState();
}
var bookmark = 'lib/assets/Photos/bookmark.png';
class _Film_ItemState extends State<Film_Item> {
  @override

  Widget build(BuildContext context) {

    return Column(
      children: [
        Stack(
          children: [
            
            ClipRRect(borderRadius: const BorderRadiusDirectional.only(topStart: Radius.circular(5), topEnd: Radius.circular(5)),
              child: Image.network(

                width: widget.width ,
                height: widget.height ,
                fit: BoxFit.fill,
                widget.img,
              ),
            ),

            InkWell(
              onTap: () {
                setState(() {
                  if(widget.wishlist){
                    widget.wishlist= false;}else {
                    widget.wishlist= true;
                  }


                });
              },
              child: Container(
                height: 29,
                child: Image.asset(
                  widget.wishlist ?'lib/assets/Photos/donebookmark.png' : 'lib/assets/Photos/bookmark.png' ,
                ),
              ),
            ),
          ],
        ),
        widget.IsInfo ? ClipRRect(
          borderRadius: const BorderRadiusDirectional.only(bottomStart: Radius.circular(5), bottomEnd: Radius.circular(5)),
          child: Container(color: Recommended ,width:   widget.width ,height:   MediaQuery.of(context).size.height* (57/870)
          ,child:Column(
               children :[
                 Row(
                   mainAxisAlignment: MainAxisAlignment.start,
                   crossAxisAlignment: CrossAxisAlignment.start,children: [
                   Padding(
                     padding: const EdgeInsets.all(3.0),
                     child: Icon(
                       Icons.star,color: MyThemeData.lightTheme.colorScheme.secondary ,
                       size : MediaQuery.of(context).size.height* (12/870),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(3.0),
                     child: Text('${widget.Rate}',style: TextStyle(

                         color: Colors.white,
                         fontSize: MediaQuery.of(context).size.height* (9/870),
                         fontWeight: FontWeight.bold),),
                   )
                 ],),
                 Text(widget.Title,style: TextStyle(
        color: Colors.white,
      fontSize: MediaQuery.of(context).size.height* (10/870),
    fontWeight: FontWeight.bold),),
                 Padding(
                   padding: const EdgeInsets.all(6.0),
                   child: Text(widget.Time,style: TextStyle(
                         color: Theme.of(context).colorScheme.onBackground,
                       fontSize: MediaQuery.of(context).size.height* (10/870),
                       fontWeight: FontWeight.bold),),
                 ),
               ]
              ) ),
        ): Container(),


      ],
    );
  }
}
