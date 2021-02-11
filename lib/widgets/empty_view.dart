import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.info_outline,
                size: 60,
              ),
              const SizedBox(height: 16),
              Text(
                message ?? 'Data Not Found!',
                textAlign: TextAlign.center,
              )
            ]),
      ),
    );
  }
}
