import '../confing.dart' as env;
class Model {
  getUrl(String value) {
    return "${env.API_URL}/${value}";
  }
}