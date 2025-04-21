import 'package:flutter/material.dart';
import 'package:movies/shared/components/film_item.dart';
import 'package:movies/shared/styles/colors.dart';

class newrles extends StatelessWidget {
  const newrles({super.key});


  static const _itemsPerRow = 3;
  static const _horizontalPadding = 16.0;
  static const _minItemWidth = 100.0;
  static const _maxItemWidth = 140.0;
  static const _aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: LayoutBuilder(builder: (context, constraints) {
        final available =
            constraints.maxWidth - (_horizontalPadding * 2);
        double itemWidth = (available / _itemsPerRow)
            .clamp(_minItemWidth, _maxItemWidth);
        final itemHeight = itemWidth / _aspectRatio;


        final cardHeight = itemHeight*0.9 + FilmItem.infoHeight(context);

        return Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: _horizontalPadding
              ),
              child: Text(
                'New Releases',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontSize: itemHeight*0.09,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: cardHeight,
              child: ListView.separated(
                padding: const EdgeInsets.only(left: _horizontalPadding),
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                separatorBuilder: (_, __) =>
                const SizedBox(width: _horizontalPadding),
                itemBuilder: (_, index) => FilmItem(
                  title: 'Movie $index',
                  time: '2024',
                  rate: 4.0,
                  showInfo: false,
                  width: itemWidth,
                  height: itemHeight,
                  imageUrl:
                  'https://m.media-amazon.com/images/M/MV5BMTMxMTU5MTY4MV5BMl5BanBnXkFtZTcwNzgyNjg2NQ@@._V1_.jpg',
                  initialInWatchlist: false,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
