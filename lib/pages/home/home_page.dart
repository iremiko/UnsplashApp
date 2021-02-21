import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_app/common/list_item.dart';
import 'package:unsplash_app/pages/home/drawer/home_drawer.dart';
import 'package:unsplash_app/pages/photos/photo_list.dart';
import 'package:unsplash_app/pages/photos/photo_list_bloc.dart';
import 'package:unsplash_app/utils/dialog_utils.dart';
import 'package:unsplash_app/widgets/empty_view.dart';
import 'package:unsplash_app/widgets/error_view.dart';
import 'package:unsplash_app/widgets/loading_view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PhotoListBloc _photoListBloc;
  StreamSubscription _photoStreamSubscription;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_photoListBloc == null) {
      _photoListBloc = PhotoListBloc();
      _photoStreamSubscription =
          _photoListBloc.data.listen((_) {}, onError: (error) {
        DialogUtils.showErrorDialog(context, error, onTryAgainTap: _onTryAgain);
      });
      _photoListBloc.firstPageSink.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Unsplash App',
          textAlign: TextAlign.start,
        ),
        centerTitle: false,
        titleSpacing: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.sort,
            ),
              onPressed: null,
             ),
          IconButton(
            icon: Icon(
              Icons.search,
            ),
              onPressed: null,
             ),
          IconButton(icon: Icon(Icons.category), onPressed: null)
        ],
      ),
      drawer: HomeDrawer(),
      body: Stack(
        children: <Widget>[
          StreamBuilder(
              stream: _photoListBloc.data,
              builder: (BuildContext context,
                  AsyncSnapshot<List<ListItem>> snapshot) {
                if (snapshot.hasData) {
                  return PhotoList(
                    bloc: _photoListBloc,
                    items: snapshot.data,
                  );
                } else if (snapshot.hasError) {
                  return ErrorView(
                      error: snapshot.error, onTryAgain: _onTryAgain);
                } else {
                  return const SizedBox();
                }
              }),
          StreamBuilder(
              initialData: false,
              stream: _photoListBloc.isLoading,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.data ? LoadingView() : const SizedBox();
              }),
          StreamBuilder(
            initialData: false,
            stream: _photoListBloc.isEmpty,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              return snapshot.data ? EmptyView() : const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _photoStreamSubscription.cancel();
    _photoListBloc.dispose();
    super.dispose();
  }

  void _onTryAgain() {
    _photoListBloc.firstPageSink.add(null);
  }
}
