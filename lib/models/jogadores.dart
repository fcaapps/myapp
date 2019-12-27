import 'dart:convert';

import 'package:http/http.dart' as http;
import 'global.dart';

class Jogadores {
  int id;
  String nome;
  int idade;
  String altura;
  int numGols;
  int numAssistencias;
  Null foto;

  Jogadores(
      {this.id,
      this.nome,
      this.idade,
      this.altura,
      this.numGols,
      this.numAssistencias,
      this.foto});

  Jogadores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    idade = json['idade'];
    altura = json['altura'];
    numGols = json['num_gols'];
    numAssistencias = json['num_assistencias'];
    //foto = json['foto'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['idade'] = this.idade;
    data['altura'] = this.altura;
    data['num_gols'] = this.numGols;
    data['num_assistencias'] = this.numAssistencias;
    data['foto'] = this.foto;
    return data;
  }
}

Future<List<Jogadores>> fetchJogadores(http.Client client) async {
  final String url = URL_JOGADORES;

  final response = await http.get(url);

  if(response.statusCode == 200) {
    final mapResponse = json.decode(response.body);
      final listOfJogadores = await mapResponse.map<Jogadores>((json) {
        return Jogadores.fromJson(json);     
      }).toList();
    return listOfJogadores;
  } else {
    throw Exception("Deu ruim");
  }
}

// Future<List<Jogadores>> fetchJogadores(http.Client client) async {
//   final response = await client.get(URL_TODO);
//   if (response.statusCode == 200) {
//     final mapResponse = json.decode(response.body);
//     //if (mapResponse[0]["result"] == "OK") {
//       final jogadores = mapResponse;
//       //final listOfJogadores = await jogadores.map<Jogadores>((json) {
//       //   return Jogadores.fromJson(json);     
//       // }).toList();
//       return jogadores;
//     // } else {
//     //   return [];
//     // }    
//   } else {
//     throw Exception('Failed to load Todo from the Internet');
//   }

// }