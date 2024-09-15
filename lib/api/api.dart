import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:rhymer2/api/models/models.dart';

part 'api.g.dart';

@RestApi(baseUrl: '')
abstract class RhymerApiClient {
  factory RhymerApiClient(Dio dio, {String? baseUrl}) = _RhymerApiClient;

  factory RhymerApiClient.create({String? apiUrl}) {
    final dio = Dio();
    dio.options.headers["X-Api-Key"] = dotenv.env['API_TOKEN'];
    if (apiUrl != null) {
      return RhymerApiClient(dio, baseUrl: apiUrl);
    }
    return RhymerApiClient(dio);
  }

  @GET('/rhyme')
  Future<List<String>> getRhymesList(@Query("word") String word);
}

extension RhymerApiClientExtensions on RhymerApiClient {
  Future<Rhymes> fetchRhymes(String word) async {
    final list = await getRhymesList(word);
    return Rhymes.fromList(list);
  }
}
