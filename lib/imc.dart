import 'package:flutter/material.dart';

class IMC {
  late int id;
  String nome;
  double altura;
  double peso;
  double imc;

  // Adicione um parâmetro nomeado 'key' ao construtor
  IMC({
    required this.nome,
    required this.altura,
    required this.peso,
    required this.imc,
    Key? key,
  });

  // Construtor para recuperar dados do SQLite
  IMC.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        nome = map['nome'],
        altura = map['altura'],
        peso = map['peso'],
        imc = map['imc'];

  // Converter dados para o formato do SQLite
  Map<String, dynamic> toMap() {
    return {'id': id, 'nome': nome, 'altura': altura, 'peso': peso, 'imc': imc};
  }
}
