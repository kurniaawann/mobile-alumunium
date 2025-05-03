import 'dart:developer';

import 'package:flutter/foundation.dart';

void printWarning(dynamic text) {
  if (kDebugMode) {
    log('\x1B[33m$text\x1B[0m');
  }
}

void printErrorDebug(dynamic text) {
  if (kDebugMode) {
    log('\x1B[31m$text\x1B[0m');
  }
}
