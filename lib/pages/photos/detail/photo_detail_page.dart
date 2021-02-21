import 'dart:async';
import 'package:flutter/material.dart';
import 'package:unsplash_app/models/photos_model.dart';
import 'package:unsplash_app/pages/photos/detail/photo_detail_bloc.dart';
import 'package:unsplash_app/utils/dialog_utils.dart';
import 'package:unsplash_app/widgets/loading_view.dart';

class PhotoDetailPage extends StatefulWidget {
  final String photoId;

  const PhotoDetailPage({Key key, this.photoId}) : super(key: key);

  @override
  _PhotoDetailPageState createState() => _PhotoDetailPageState();
}

class _PhotoDetailPageState extends State<PhotoDetailPage> {
  PhotoDetailBloc _photoDetailBloc;
  StreamSubscription _photoStreamSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_photoDetailBloc == null) {
      _photoDetailBloc = PhotoDetailBloc(photoId: widget.photoId);
      _photoStreamSubscription =
          _photoDetailBloc.data.listen((_) {}, onError: (error) {
        DialogUtils.showErrorDialog(context, error, onTryAgainTap: _onTryAgain);
      });
      _photoDetailBloc.getPhotoDetail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _photoDetailBloc.data,
      builder: (BuildContext context, AsyncSnapshot<Photos> snapshot) {
        Widget body;
        if (snapshot.hasData) {
          Photos photo = snapshot.data;
          body = SingleChildScrollView(

             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Image.network(
                   photo.photosUrl.regular,
                 ),
                 if(photo.userProfile != null && photo.userProfile.username.isNotEmpty)
                   Padding(
                     padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                     child: Text('@${photo.userProfile.username}', style: Theme.of(context).textTheme.headline6,),
                   ),
                 if(photo.description != null)
                 Padding(
                   padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                   child: Text(photo.description),
                 ),
                 if(photo.altDescription != null)
                   Padding(
                     padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
                     child: Text(photo.altDescription),
                   ),
                 SizedBox(height: 8.0,)
               ],
             ),

          );
        } else {
          body = LoadingView();
        }
        return Scaffold(
          appBar: AppBar(),
          body: body,
        );
      },
    );
  }

  @override
  void dispose() {
    _photoStreamSubscription.cancel();
    _photoDetailBloc.dispose();
    super.dispose();
  }

  void _onTryAgain() {
    _photoDetailBloc.getPhotoDetail();
  }
}
