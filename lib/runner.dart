import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/src/features/app/news_app.dart';
import 'package:news_app/src/features/navigation/service/bloc/navigation_bloc.dart';
import 'package:news_app/src/features/norifications/service/notification_service.dart';
import 'package:surf_logger/surf_logger.dart';

/// App launch
Future<void> run() async {
  _initLogger();
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(BlocProvider(
      create: (context) => NavigationBloc(), child: const NewsApplication()));
}

void _initLogger() {
  Logger.addStrategy(DebugLogStrategy());
}
