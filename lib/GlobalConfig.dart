class GlobalsConfig {
  static GlobalsConfig? _instance;

  factory GlobalsConfig() => _instance ??= GlobalsConfig._();

  GlobalsConfig._();

  // Contoh variabel global
 static String url_api = "https://ayolapor-api.evolve-innovation.com/api/";
}
