import 'package:flutter/material.dart';
import 'task.dart';
import 'package:http/http.dart' as http;

class TaskScreen extends StatefulWidget {
  final int todoId;

  TaskScreen({this.todoId}):super();

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tarefas'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
                  
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: fetchTasks(http.Client(), widget.todoId),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
            ? TaskList(tasks: snapshot.data)
            : Center(child: CircularProgressIndicator());  
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Tasks> tasks;

  const TaskList({Key key, this.tasks}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            color: index % 2 == 0 ? Colors.deepOrangeAccent : Colors.amber,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.tasks[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text('Finalizado: ${tasks[index].isfinished == true?"Sim":"Não"}', style: TextStyle(fontSize: 16,))
              ],
            ),
          ),
        );
      },
      itemCount: this.tasks.length,
    );
  }
}