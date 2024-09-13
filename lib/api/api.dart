import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:retrofit/retrofit.dart';

import 'models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String? baseUrl}) = _RhymerApiClient;

  @GET('/rhyme')
  Future <List<String>> getRhymesList(
    @Query("word") String word,
  );
}

RhymerApiClient initApiClient() {
  final apiUrl = dotenv.env['API_URL'];
  final dio = Dio();
  dio.options.headers["X-Api-Key"] = dotenv.env['API_TOKEN'];
  if (apiUrl != null) {
    return RhymerApiClient(dio, baseUrl: apiUrl);
  }
  return RhymerApiClient(dio);
}
