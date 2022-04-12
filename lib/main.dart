import 'package:blue/src/provider/sqflite.dart';
import 'package:blue/src/provider/user.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'package:blue/src/app.dart';
import 'package:blue/src/provider/location.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocationProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      Provider(create: (_) => SqfliteProvider()),
    ], child: const App()),
  );
}