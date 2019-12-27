import 'dart:convert';
import 'package:http/http.dart' as http;
import 'global.dart';

class Todo {
  int id;
  String name;
  String dueDate;
  String description;

  Todo({this.id, this.name, this.dueDate, this.description});

  Todo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    dueDate = json['dueDate'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['dueDate'] = this.dueDate;
    data['description'] = this.description;
    return data;
  }
}

Future<List<Todo>> fetchTodos(http.Client client) async {
  final response = await client.get(URL_TODO);
  if (response.statusCode == 200) {
    final mapResponse = json.decode(response.body);
    final todo = mapResponse.cast<Map<String, dynamic>>();
    final listOfTodo = await todo.map<Todo>((json) {
        return Todo.fromJson(json);     
      }).toList();
      return listOfTodo;        
  } else {
    throw Exception('Failed to load Todo from the Internet');
  }

}

// Future<List<Todo>> fetchTodos(http.Client client) async {
//   final response = await client.get(URL_TODO);
//   if (response.statusCode == 200) {
//     final mapResponse = json.decode(response.body);
//     if (mapResponse[0]["result"] == "OK") {
//       final todo = mapResponse[0]["data"].cast<Map<String, dynamic>>();
//       final listOfTodo = await todo.map<Todo>((json) {
//         return Todo.fromJson(json);     
//       }).toList();
//       return listOfTodo;
//     } else {
//       return [];
//     }    
//   } else {
//     throw Exception('Failed to load Todo from the Internet');
//   }

// }