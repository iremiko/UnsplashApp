import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unsplash_app/models/user_profile_model.dart';
import 'package:unsplash_app/pages/home/drawer/home_drawer_bloc.dart';
import 'package:unsplash_app/utils/color_utils.dart';
import 'package:unsplash_app/utils/dialog_utils.dart';
import 'package:unsplash_app/widgets/error_view.dart';
import 'package:unsplash_app/widgets/loading_view.dart';

class HomeDrawer extends StatefulWidget {
  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  HomeDrawerBloc _bloc;
  StreamSubscription _streamSubscription;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_bloc == null) {
      _bloc = HomeDrawerBloc();
      _bloc.getUserProfile();
      _streamSubscription = _bloc.data.listen((_) {}, onError: (error) {
        DialogUtils.showErrorDialog(context, error, onTryAgainTap: _onTryAgain);
      });
    }
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _bloc.data,
      builder: (BuildContext context, AsyncSnapshot<UserProfile> snapshot) {
        if (snapshot.hasData) {
          UserProfile model = snapshot.data;
          return Drawer(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: Container(
                      color: ColorUtils.secondaryColor,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                              maxRadius: (MediaQuery.of(context).size.width -
                                          kToolbarHeight) /
                                      7 +
                                  8.0,
                              backgroundColor: ColorUtils.primaryColor,
                              child: CircleAvatar(
                                backgroundColor: ColorUtils.primaryColor,
                                backgroundImage:
                                    NetworkImage(model.image.large ?? ''),
                                maxRadius: (MediaQuery.of(context).size.width -
                                        kToolbarHeight) /
                                    7,
                              ),
                            ),
                          ),
                          Text(model.username, style: Theme.of(context).textTheme.headline6.copyWith(fontSize: 18),),
                        ],
                      ),
                    ),
                  ),
                  ListTile(leading: Icon(Icons.supervised_user_circle_outlined), title: Text('Followers'),
                      trailing: Text('${model.followersCount}')),
                Divider(height: 0,),
                  ListTile(leading: Icon(Icons.supervised_user_circle),
                      title: Text('Following',), trailing: Text('${model.followingCount}',), ),
                  Divider(height: 0,),
                  ListTile(leading: Icon(Icons.photo_album),
                    title: Text('Photos',),),
                  Divider(height: 0,),
                ]),
          );
        } else if (snapshot.hasError) {
          return ErrorView(error: snapshot.error, onTryAgain: _onTryAgain);
        } else {
          return LoadingView();
        }
      },
    );
  }

  void _onTryAgain() {
    _bloc.getUserProfile();
  }
}
