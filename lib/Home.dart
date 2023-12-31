import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController txtcep = new TextEditingController();
  late String resultado;

  _consultaCep() async {
    String cep = txtcep.text;
    String url = 'https://viacep.com.br/ws/${cep}/json/';

    http.Response response;
    response = await http.get(Uri());
    Map<String, dynamic> retorno = json.decode(response.body);
    String logradouro = retorno["logradouro"];
    String cidade = retorno["localidade"];
    String bairro = retorno["bairro"];

    _consultaCep() {
      resultado = '${logradouro}, + ${bairro}, + ${cidade}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultando um CEP via API'),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(40),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              decoration:
                  InputDecoration(labelText: 'Digite o CEP ex: 12345678901'),
              controller: txtcep,
            ),
            Text(
              'Resultado: ${resultado}',
              style: TextStyle(fontSize: 25),
            ),
            FloatingActionButton(
              child: Text(
                'Consultar',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ), backgroundColor: Colors.blue,
              onPressed: _consultaCep,
  
            )
          ],
        ),
      ),
    );
  }
}


