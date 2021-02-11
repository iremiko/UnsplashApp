
import 'package:flutter/material.dart';
import 'package:unsplash_app/common/list_item.dart';
import 'package:unsplash_app/models/photos_model.dart';
import 'package:unsplash_app/pages/photos/photo_list_item.dart';
import 'package:unsplash_app/widgets/error_view.dart';
import 'package:unsplash_app/widgets/loading_view.dart';

typedef Widget CardBuilder(Photos photos);

class PhotoListItemView extends StatelessWidget {
  final ListItem listItem;
  final Function onTryAgain;
  final CardBuilder buildCard;

  PhotoListItemView(this.listItem, this.onTryAgain, this.buildCard);

  @override
  Widget build(BuildContext context) {
    if (listItem is PhotoListItem) {
      PhotoListItem item = listItem;
      return buildCard(item.photos);
    } else if (listItem is LoadingItem) {
      return LoadingView();
    } else if (listItem is LoadingFailed) {
      LoadingFailed item = listItem;
      return ErrorView(
        error: item.error,
        onTryAgain: onTryAgain,
      );
    } else {
      throw Exception('listItem is unknown!');
    }
  }
}
