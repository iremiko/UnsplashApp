
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:unsplash_app/common/list_item.dart';
import 'package:unsplash_app/models/photos_model.dart';
import 'package:unsplash_app/pages/photos/detail/photo_detail_page.dart';
import 'package:unsplash_app/pages/photos/photo_list_bloc.dart';
import 'package:unsplash_app/pages/photos/photo_list_item_view.dart';

///ListView which controls pagination

class PhotoList extends StatefulWidget {
  final PhotoListBloc bloc;
  final List<ListItem> items;

  PhotoList({this.bloc, this.items, Key key}) : super(key: key);

  @override
  _PhotoListState createState() {
    return _PhotoListState();
  }
}

class _PhotoListState extends State<PhotoList> {
  final ScrollController _scrollController = ScrollController();
  final log = Logger('_PhotoListState');

  @override
  void initState() {
    log.info("------initState: PhotoList");
    _scrollController.addListener(_handleNextPageLoading);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleNextPageLoading);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(PhotoList oldWidget) {
    log.info("------didUpdateWidget: PhotoList");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    log.info("------build: PhotoList");
    return RefreshIndicator(
      onRefresh: widget.bloc.refresh,
      child: GridView.builder(
        padding: EdgeInsets.all(
            8.0
        ),
        itemCount: widget.items.length,
        shrinkWrap: true,
        gridDelegate:
        new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0),
        itemBuilder: (BuildContext context, int index) {
          return PhotoListItemView(widget.items[index], _onRetry, _buildItem);
        },
        controller: _scrollController,
      ),


    );
  }

  void _handleNextPageLoading() {
    //Start loading next page when visible content 500 pixels close
    //to end of the scroll.
    if (_scrollController.position.extentAfter < 500) {
      widget.bloc.nextPageSink.add(null);
    }
  }

  void _onRetry() {
    widget.bloc.nextPageRetrySink.add(null);
  }

  Widget _buildItem(Photos photos) {
    return GestureDetector(
      onTap: ()=>   Navigator.of(context).push(
        MaterialPageRoute(
            builder: (_) => PhotoDetailPage(
             photoId: photos.id,)
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: '${photos.photosUrl.regular?? ''}',
        fit: BoxFit.cover,
      ),
    );
  }
}
