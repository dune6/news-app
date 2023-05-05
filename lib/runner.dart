import 'package:flutter/material.dart';
import 'package:news_app/src/features/app/news_app.dart';
import 'package:surf_logger/surf_logger.dart';

/// App launch.
Future<void> run() async {
  _initLogger();
  runApp(const NewsApplication());
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}
