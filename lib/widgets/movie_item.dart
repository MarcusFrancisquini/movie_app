// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class MovieListItem extends StatelessWidget {

  final String cover;
  final String name;
  final String info;
  final GlobalKey backgroundImageKey = GlobalKey();

  MovieListItem({super.key, required this.cover, required this.name, required this.info});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            children: [
              //* imagem
              Flow(
                delegate: _ParallaxFlowDelegate(
                  scrollable: Scrollable.of(context),
                  listItemContext: context,
                  backgroundImageKey: backgroundImageKey
                ),
                children: [
                  Image.asset(
                    cover,
                    key: backgroundImageKey,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ],
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.6,
                        0.95
                      ]
                    )
                  ),
                ),
              ),
              //* textos
              Positioned(
                left: 20,
                bottom: 20,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        info,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//? efeito parallax

class _ParallaxFlowDelegate extends FlowDelegate {

  final ScrollableState scrollable;
  final BuildContext listItemContext;
  final GlobalKey backgroundImageKey;

  _ParallaxFlowDelegate({required this.scrollable, required this.listItemContext, required this.backgroundImageKey}) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints){
    return BoxConstraints.tightFor(
      width: constraints.maxWidth
    );
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    // calcular a posição
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final listItemBox = listItemContext.findRenderObject() as RenderBox;
    final listItemOffset = listItemBox.localToGlobal(
      listItemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox
    );

    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (listItemOffset.dy / viewportDimension).clamp(0.0, 1.0);

    final verticalAlignment = Alignment(0.0, scrollFraction * 2 - 1);

    final backgroundSize = (backgroundImageKey.currentContext!.findRenderObject() as RenderBox).size;
    final listItemSize = context.size;
    final childRect = verticalAlignment.inscribe(backgroundSize, Offset.zero & listItemSize);

    context.paintChild(
      0,
      transform: Transform.translate(offset: Offset(0.0, childRect.top)).transform
    );
  }

  @override
  bool shouldRepaint(covariant _ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
    listItemContext != oldDelegate.listItemContext ||
    backgroundImageKey != oldDelegate.backgroundImageKey;
  }
   
}