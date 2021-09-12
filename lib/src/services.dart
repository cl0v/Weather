import 'package:http/http.dart';

abstract class IHttpClient {
  Future<Response> get(Uri uri);
}

class HttpClientService implements IHttpClient {
  const HttpClientService();
  @override
  Future<Response> get(uri) {
    return Client().get(uri);
  }
}
