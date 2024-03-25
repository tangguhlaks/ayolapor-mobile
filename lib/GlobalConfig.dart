class GlobalsConfig {
  static GlobalsConfig? _instance;

  factory GlobalsConfig() => _instance ??= GlobalsConfig._();

  GlobalsConfig._();

  // Contoh variabel global
 static String url_api = "http://127.0.0.1:8000/api/";
}
