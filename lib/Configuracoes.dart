// configuracoes.dart
class Configuracoes {
  double altura = 1.70; // Altura padrão, você pode alterar conforme necessário

  // Singleton para garantir uma única instância
  static final Configuracoes _instance = Configuracoes._internal();

  factory Configuracoes() => _instance;

  Configuracoes._internal();
}
