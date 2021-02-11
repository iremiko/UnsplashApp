import 'package:flutter/material.dart';
import 'package:unsplash_app/pages/home/home_page.dart';
import 'package:unsplash_app/utils/color_utils.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unsplash App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryTextTheme: TextTheme(
            headline6: TextStyle(
                color: ColorUtils.backgroundColor
            )
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        backgroundColor: ColorUtils.backgroundColor,
        scaffoldBackgroundColor: ColorUtils.backgroundColor,
        cardColor: Colors.white,
        accentColor: ColorUtils.accentColor,
        unselectedWidgetColor: ColorUtils.accentColor,
        errorColor: ColorUtils.errorColor,

        tabBarTheme: TabBarTheme(
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: ColorUtils.secondaryColor)),
          labelColor: ColorUtils.accentColor,
          unselectedLabelColor: ColorUtils.primaryColor,
        ),

        primaryColor: ColorUtils.primaryColor,
        dividerColor: ColorUtils.primaryColor,
        iconTheme: IconThemeData(color: ColorUtils.secondaryColor),
        primaryIconTheme: IconThemeData(color: ColorUtils.primaryColor),
        accentIconTheme: IconThemeData(color: ColorUtils.accentColor),
        textTheme: TextTheme(
          headline6: Theme.of(context).textTheme.headline6.copyWith(color: ColorUtils.textPrimaryColor),
          headline5: Theme.of(context).textTheme.headline5.copyWith(color: ColorUtils.textPrimaryColor),
          subtitle1: Theme.of(context).textTheme.subtitle1.copyWith(color: ColorUtils.textPrimaryColor),
          bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(color: ColorUtils.textSecondaryColor),
          bodyText1: Theme.of(context).textTheme.bodyText1.copyWith(color: ColorUtils.textSecondaryColor),
          caption: Theme.of(context).textTheme.caption.copyWith(color: ColorUtils.textPrimaryColor),
        ),
      ),
      home: HomePage(),
    );
  }
}
