import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rhymer2/api/api.dart';
import 'package:rhymer2/features/search/bloc/rhymes_list_bloc.dart';
import 'package:rhymer2/router/router.dart';
import 'package:rhymer2/ui/theme/theme.dart';

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
    return BlocProvider(
      create: (context) => RhymesListBloc(
        apiClient: RhymerApiClient.create(
          apiUrl: dotenv.env["API_URL"],
        ),
      ),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Rhymer',
        theme: themeData,
        routerConfig: _router.config(),
      ),
    );
  }
}
