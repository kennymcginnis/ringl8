import 'package:flutter/material.dart';
import 'package:ringl8/components/ListItem.dart';
import 'package:ringl8/screens/home/data.dart';

class ListViewContent extends StatelessWidget {
  final Animation<double> listTileWidth;
  final Animation<Alignment> listSlideAnimation;
  final Animation<EdgeInsets> listSlidePosition;

  ListViewContent({
    this.listSlideAnimation,
    this.listSlidePosition,
    this.listTileWidth,
  });

  @override
  Widget build(BuildContext context) {
    DataListBuilder dataListBuilder = DataListBuilder();
    var i = dataListBuilder.rowItemList.length + 0.5;
    return Stack(
      alignment: listSlideAnimation.value,
      children: dataListBuilder.rowItemList.map((RowBoxData rowBoxData) {
        return ListItem(
          title: rowBoxData.title,
          subtitle: rowBoxData.subtitle,
          image: rowBoxData.image,
          width: listTileWidth.value,
          margin: listSlidePosition.value * (--i).toDouble(),
        );
      }).toList(),
    );
  }
}
