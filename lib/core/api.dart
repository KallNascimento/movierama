import 'package:dio/dio.dart';

const kBaseUrl = 'https://api.themoviedb.org/3';

const kApikey =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5Y2Y3NWM0ZTUwNWMxZGI3ZGIxNjMzNDNiMGQ2MmM4NyIsInN1YiI6IjYwODA3ZDBkYzQzOWMwMDAyYTNhNDU3ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.pf0B_3msBPkwxocFhyhQHBRpfXqT3amL3eCmG2mS0yo';

const kServerError = 'Falha ao conectar o servidor. Tente depois';

final kDioOptions = BaseOptions(
  baseUrl: kBaseUrl,
  connectTimeout: 5000,
  receiveTimeout: 3000,
  contentType: 'application/json; charset=utf-8',
  headers: {'Authorization': 'Bearer $kApikey'},
);
