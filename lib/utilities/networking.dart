import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    try {
      http.Response r = await http.get(url);

      if (r.statusCode != 200) {
        print(r.statusCode);
      } else {
        return jsonDecode(r.body);
      }
    } catch (e) {
      print(e);
    }
  }
}
