import 'dart:convert';
import 'package:http/http.dart' as http;
import 'global.dart';

class Tasks {
  int id;
  int todoid;
  String name;
  bool isfinished;

  Tasks({this.id, this.todoid, this.name, this.isfinished});

  factory Tasks.fromJson(Map<String, dynamic> json) {

    Tasks newTask = Tasks(
      id: json['id'],
      todoid: json['todoid'],
      name: json['name'],
      isfinished: json['isfinished']
    );

    return newTask;

    
  }

  Tasks.fromTask(Tasks anotherTask) {
    id = anotherTask.id;
    todoid = anotherTask.todoid;
    name =anotherTask.name;
    isfinished = anotherTask.isfinished;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['todoid'] = this.todoid;
    data['name'] = this.name;
    data['isfinished'] = this.isfinished;
    return data;
  }
}


Future<List<Tasks>> fetchTasks(http.Client client, int todoid) async {
  final response = await client.get('$URL_TASKS_BY_TODOID$todoid');
  if (response.statusCode == 200) {
    final mapResponse = json.decode(response.body);
    final todo = mapResponse.cast<Map<String, dynamic>>();
    final listOfTodo = await todo.map<Tasks>((json) {
        return Tasks.fromJson(json);     
      }).toList();
      return listOfTodo;        
  } else {
    throw Exception('Failed to load Todo from the Internet');
  }

}


// Future<List<Tasks>> fetchTasks(http.Client client, int todoid) async {
//   final response = await client.get('$URL_TASKS_BY_TODOID$todoid');
//   print(response.statusCode);
//   if (response.statusCode == 200) {
//     Map<String, dynamic> mapResponse = json.decode(response.body);
//     if (mapResponse["result"] == "OK") {
//       final tasks = mapResponse["data"].cast<Map<String, dynamic>>();
//         return tasks.map<Tasks>((json) {
//           return Tasks.fromJson(json);
//         }).toList();     
//     } else {
//       return [];
//     }    
//   } else {
//     print(response.statusCode);
//     throw Exception('Failed to load Tasks from the Internet');
//   }


// }