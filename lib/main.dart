import 'package:flutter/material.dart';
import 'package:rhymer2/api/api.dart';
import 'package:rhymer2/router/router.dart';
import 'package:rhymer2/ui/theme/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  
  final client = initApiClient();
  runApp(RhymerApp(
    apiClient: client,
  ));
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({super.key, required this.apiClient});

  final RhymerApiClient apiClient;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  void initState() {
    widget.apiClient.getRhymesList("grass").then((res) => print(res));
    super.initState();
  }

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
