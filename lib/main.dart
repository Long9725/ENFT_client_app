import 'package:blue/src/provider/location.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import './src/app.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => LocationProvider()),
    ], child: const App()),
  );
}