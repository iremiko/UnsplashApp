import 'package:flutter/material.dart';
import 'package:unsplash_app/utils/error_utils.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key key, this.error, this.onTryAgain}) : super(key: key);

  final dynamic error;
  final Function onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
              child:
              SingleChildScrollView(child: Text(ErrorUtils.getFriendlyErrorMessage(context, error)))),
          SizedBox(height: 8.0),
          onTryAgain != null
              ? RaisedButton(
            child: Text('Try Again'),
            onPressed: onTryAgain,
          )
              : SizedBox(),
        ],
      ),
    );
  }
}
