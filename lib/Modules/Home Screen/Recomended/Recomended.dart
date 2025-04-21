import 'package:flutter/material.dart';
import 'package:movies/shared/components/film_item.dart';
import 'package:movies/shared/styles/colors.dart';

class Recommended extends StatelessWidget {
  const Recommended({super.key});

  static const _horizontalPadding = 16.0;
  static const _minItemWidth = 96.0;
  static const _maxItemWidth = 140.0;
  static const _itemsPerRow = 3;
  static const _aspectRatio = 2 / 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GREY_COLOR,
      padding:
      const EdgeInsets.symmetric(vertical: 10, horizontal: _horizontalPadding),
      child: LayoutBuilder(builder: (ctx, constraints) {
        final available = constraints.maxWidth - _horizontalPadding * 2;
        double itemW =
        (available / _itemsPerRow).clamp(_minItemWidth, _maxItemWidth);
        final itemH = itemW / _aspectRatio;

        // ← remove the + _horizontalPadding here
        final cardH = itemH*1.2 + FilmItem.infoHeight(context);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: _horizontalPadding,vertical: 2),
            child: Text(
              'Recommended',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,fontSize: itemH*0.09
              ),
            ),
          ),

            SizedBox(
              height: cardH,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.only(top: 8),
                itemCount: 10,
                separatorBuilder: (_, __) =>
                const SizedBox(width: _horizontalPadding),
                itemBuilder: (_, i) => FilmItem(
                  title: 'Avengers Endgame',
                  time: '2018 • 1h 59m',
                  rate: 9,
                  showInfo: true,
                  width: itemW,
                  height: itemH,
                  imageUrl:
                  'https://media0004.elcinema.com/uploads/_315x420_b900b6d7169ab527ee0eaa45665743e50e0dfa408a1e679b49821357c6c78f6f.jpg',
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
