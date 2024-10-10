import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realm/realm.dart';
import 'package:rhymer2/bloc/theme/theme_cubit.dart';
import 'package:rhymer2/features/favorite/bloc/favorite_rhymes_bloc.dart';
import 'package:rhymer2/features/history/bloc/history_rhymes_bloc.dart';
import 'package:rhymer2/repositories/favorite/favorite.dart';
import 'package:rhymer2/repositories/favorite/model/favorite_rhymes.dart';
import 'package:rhymer2/repositories/history/history.dart';
import 'package:rhymer2/repositories/history/models/history_rhymes.dart';
import 'package:rhymer2/repositories/settings/settings.dart';
import 'package:rhymer2/router/router.dart';
import 'package:rhymer2/ui/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/api.dart';
import 'features/search/bloc/rhymes_list_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final config =
      Configuration.local([HistoryRhymes.schema, FavoriteRhymes.schema]);
  final realm = Realm(config);
  final prefs = await SharedPreferences.getInstance();
  runApp(RhymerApp(realm: realm, preferences: prefs));
}

class RhymerApp extends StatefulWidget {
  const RhymerApp({super.key, required this.realm, required this.preferences});

  final Realm realm;
  final SharedPreferences preferences;

  @override
  State<RhymerApp> createState() => _RhymerAppState();
}

class _RhymerAppState extends State<RhymerApp> {
  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final historyRepository = HistoryRepository(realm: widget.realm);
    final favoriteRepository = FavoriteRepository(realm: widget.realm);
    final settingsRepository =
        SettingsRepository(preferences: widget.preferences);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RhymesListBloc(
            apiClient: RhymerApiClient.create(apiUrl: dotenv.env["API_URL"]),
            historyRepository: HistoryRepository(realm: widget.realm),
            favoriteRepositoryInterface: favoriteRepository,
          ),
        ),
        BlocProvider(
          create: (context) => HistoryRhymesBloc(
            historyRepository: historyRepository,
          ),
        ),
        BlocProvider(
          create: (context) => FavoriteRhymesBloc(
            favoriteRepository: favoriteRepository,
          ),
        ),
        BlocProvider(
          create: (context) =>
              ThemeCubit(settingsRepository: settingsRepository),
        )
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Rhymer',
            theme: state.isDark ? darkTheme : lightTheme,
            routerConfig: _router.config(),
          );
        },
      ),
    );
  }
}
