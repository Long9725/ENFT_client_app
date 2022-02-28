import 'package:blue/src/provider/location.dart';
import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import './src/app.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ], child: const App()),
  );
}