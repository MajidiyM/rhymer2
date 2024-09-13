import 'package:flutter/material.dart';
import 'package:rhymer2/api/api.dart';
import 'package:rhymer2/router/router.dart';
import 'package:rhymer2/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final client = RhymerApiClient.create(apiUrl: dotenv.env['API_URL']);
  runApp(RhymerApp());
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({super.key});

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Rhymer',
      theme: themeData,
      routerConfig: _router.config(),
    );
  }
}
