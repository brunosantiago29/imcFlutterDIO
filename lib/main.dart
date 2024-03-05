import 'package:flutter/material.dart';
import 'imc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<IMC> listaDeIMC = [];

  TextEditingController nomeController = TextEditingController();
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

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
              controller: nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: alturaController,
              decoration: const InputDecoration(labelText: 'Altura (m)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (value) {
                // Lógica para substituir vírgula por ponto e garantir o ponto decimal
                alturaController.text = value.replaceAll(',', '.');
                if (!alturaController.text.contains('.')) {
                  alturaController.text =
                      "${alturaController.text.substring(0, 1)}.${alturaController.text.substring(1)}";
                }
              },
            ),
            TextField(
              controller: pesoController,
              decoration: const InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                calcularIMCUsuario();
                limparCampos();
              },
              child: const Text('Calcular IMC'),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: listaDeIMC.isNotEmpty
                  ? ListView.builder(
                      itemCount: listaDeIMC.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                              '${listaDeIMC[index].nome} - IMC: ${listaDeIMC[index].imc.toStringAsFixed(2)} - ${calcularIMCIndividual(index)}'),
                          trailing: ElevatedButton(
                            onPressed: () {
                              apagarUsuario(index);
                            },
                            child: const Text('Apagar'),
                          ),
                        );
                      },
                    )
                  : const Text('Nenhum IMC calculado ainda.'),
            ),
          ],
        ),
      ),
    );
  }

  void calcularIMCUsuario() {
    double altura = double.tryParse(alturaController.text) ?? 0.0;
    double peso = double.tryParse(pesoController.text) ?? 0.0;

    if (altura > 0 && peso > 0) {
      double imc = peso / (altura * altura);
      IMC novoIMC = IMC(
        nome: nomeController.text,
        altura: altura,
        peso: peso,
        imc: imc,
      );
      listaDeIMC.add(novoIMC);
      setState(() {});
    } else {
      // Lógica para lidar com valores inválidos (altura ou peso não positivos)
      // Pode exibir uma mensagem de erro ou tomar outra ação, conforme necessário.
    }
  }

  String calcularIMCIndividual(int index) {
    double total = listaDeIMC[index].imc;
    String resultado;

    if (total <= 18.5) {
      resultado = "Abaixo do normal";
    } else if (total <= 24.9) {
      resultado = "Normal";
    } else if (total <= 29.9) {
      resultado = "Sobrepeso";
    } else if (total <= 34.9) {
      resultado = "Obesidade grau 1";
    } else if (total <= 39.9) {
      resultado = "Obesidade grau 2";
    } else {
      resultado = "Obesidade grau 3";
    }

    return resultado;
  }

  void limparCampos() {
    nomeController.clear();
    alturaController.clear();
    pesoController.clear();
  }

  void apagarUsuario(int index) {
    if (index >= 0 && index < listaDeIMC.length) {
      listaDeIMC.removeAt(index);
      setState(() {});
    }
  }
}
