import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/models/TaskScreen.dart';
import 'todo.dart';
import 'TaskScreen.dart';

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Todos from Restful Api'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _carregaTodo();  
              });
            },
          )
        ],
      ),
      body: _carregaTodo()
      
    );
  }
}

_carregaTodo() {
  return FutureBuilder(
        future: fetchTodos(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);    
          }
          return snapshot.hasData 
          ? TodoList(todo: snapshot.data)
          : Center(child: CircularProgressIndicator(),);
        },
      );
}


class TodoList extends StatelessWidget {
  
  final List<Todo> todo;

  TodoList({Key key, this.todo}) : super(key: key);  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            color: index % 2 == 0 ? Colors.greenAccent : Colors.cyan,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(todo[index].name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text('Descrição: ${todo[index].description}', style: TextStyle(fontSize: 16),),
                
              ],
            ),
          ),
          onTap: () {
            Navigator.push(context,
              MaterialPageRoute(builder: (context) => TaskScreen(todoId: todo[index].id,)) 
            );    
          },
        );
      },
      itemCount: todo.length,
    );
  }
}
