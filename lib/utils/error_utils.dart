import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

class ErrorUtils{
  static String getFriendlyErrorMessage(BuildContext context, dynamic error) {
    if (error is TimeoutException) {
      return 'Connection timeout';
    }
    if (error is SocketException) {
      return 'You have no internet connection';
    } else {
      return error.toString();
    }
  }
}