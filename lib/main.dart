import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rbc_control/setup.dart';
import 'app.dart';

Future<void> main() async {
  await setup();
  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
