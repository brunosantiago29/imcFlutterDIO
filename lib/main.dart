// lib/main.dart
import 'package:flutter/material.dart';
import "pessoa.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Pessoa> listaDePessoas = [];

  String nome = '';
  int idade = 0;
  double altura = 0.0;
  double peso = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Nome'),
              onChanged: (value) => nome = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => altura = double.tryParse(value) ?? 0.0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => peso = double.tryParse(value) ?? 0.0,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calcularIMC();
                limparCampos();
              },
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: listaDePessoas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        '${listaDePessoas[index].nome} - IMC: ${calcularIMCIndividual(index)}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calcularIMC() {
    peso / (altura * altura);
    Pessoa novaPessoa = Pessoa(nome, altura as double, peso as double);
    listaDePessoas.add(novaPessoa);
    setState(() {});
  }

  double calcularIMCIndividual(int index) {
    double total = listaDePessoas[index].peso /
        (listaDePessoas[index].altura * listaDePessoas[index].altura);
    return total;
  }

  void limparCampos() {
    nome = '';
    altura = 0.0;
    peso = 0.0;
  }
}
