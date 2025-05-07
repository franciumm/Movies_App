import 'package:flutter/material.dart';
import 'package:movies/shared/styles/colors.dart';

import 'MovieDetailDialog.dart';

class FilmItem extends StatefulWidget {
  const FilmItem({
    required this.title,
    required  this.movieId,
    required this.time,
    required this.rate,
    required this.showInfo,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.initialInWatchlist = false,
    super.key,
  });

  final String title;
  final int movieId;
  final String time;
  final String imageUrl;
  final double rate;
  final double width;
  final double height;
  final bool showInfo;
  final bool initialInWatchlist;

  // Height reserved for info strip
  static const _infoPad = 8.0;
  static double infoHeight(BuildContext ctx) =>
      MediaQuery.of(ctx).size.height * (57 / 870) + _infoPad;

  @override
  State<FilmItem> createState() => _FilmItemState();
}

class _FilmItemState extends State<FilmItem> {
  late bool _inWatchlist;

  @override
  void initState() {
    super.initState();
    _inWatchlist = widget.initialInWatchlist;
  }

  @override
  Widget build(BuildContext context) {
    Widget poster;
    if (widget.imageUrl.isNotEmpty) {
      poster = Image.network(
        widget.imageUrl,
        width: widget.width,
        height: widget.height,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(),
      );
    } else {
      poster = _placeholder();
    }

    return GestureDetector(onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => MovieDetailScreen(movieId: widget.movieId),
        ),
      );
    },
      child: Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            width: widget.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Poster + bookmark icon
                Stack(
                  children: [
                    poster,
                    Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () =>
                            setState(() => _inWatchlist = !_inWatchlist),
                        child: Image.asset(
                          _inWatchlist
                              ? 'lib/assets/Photos/donebookmark.png'
                              : 'lib/assets/Photos/bookmark.png',
                          width: 29,
                          height: 29,
                        ),
                      ),
                    ),
                  ],
                ),

                // Optional info strip below
                if (widget.showInfo)
                  Container(
                    width: widget.width,
                    color: Recommended,
                    padding:  EdgeInsets.fromLTRB(widget.width*0.04, widget.height*0.07,0, widget.height*0.07),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              widget.rate.toString().substring(0, 3),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Text(
                          widget.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.time,
                          style: TextStyle(
                            color: TextBack,
                             fontSize: 10
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _placeholder() {
    return Container(
      width: widget.width,
      height: widget.height,
      color: Colors.grey[800],
      child: const Icon(
        Icons.image_not_supported,
        color: Colors.white54,
        size: 40,
      ),
    );
  }
}