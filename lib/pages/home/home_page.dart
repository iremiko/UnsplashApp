import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_app/common/list_item.dart';
import 'package:unsplash_app/pages/photos/photo_list.dart';
import 'package:unsplash_app/pages/photos/photo_list_bloc.dart';
import 'package:unsplash_app/utils/color_utils.dart';
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
 TextEditingController _searchController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_photoListBloc == null) {
      _photoListBloc = PhotoListBloc();
      _photoStreamSubscription = _photoListBloc.data.listen((_) {}, onError: (error) {
        DialogUtils.showErrorDialog(context, error, onTryAgainTap: _onTryAgain);
      });
      _photoListBloc.firstPageSink.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Unsplash App'),),
      body: Column(
        children: [
          Card(
            elevation: 4,
            margin: EdgeInsets.all(0.0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
            child: Container(
              height: kToolbarHeight,
              color: ColorUtils.secondaryColor,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      color: ColorUtils.backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: TextField(
                            //    controller: _searchController,
                                textInputAction: TextInputAction.search,
                                onSubmitted: (String value) {
                                  // _searchTap();
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            IconButton(
                                onPressed: () {
                                  // _searchTap();
                                },
                                icon: Icon(
                                  Icons.search,
                                  size: 24,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.category), onPressed: null)
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
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
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return snapshot.data ? LoadingView() : const SizedBox();
                    }),
                StreamBuilder(
                  initialData: false,
                  stream: _photoListBloc.isEmpty,
                  builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                    return snapshot.data
                        ? EmptyView(
                    )
                        : const SizedBox();
                  },
                ),
              ],
            ),
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
