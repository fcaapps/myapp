import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'jogadores.dart';

class JogadoresScreen extends StatefulWidget {
  @override
  _JogadoresState createState() => _JogadoresState();
}

class _JogadoresState extends State<JogadoresScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fetch Todos from Restful Api'),
      ),
      body: FutureBuilder(
        future: fetchJogadores(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            print(snapshot.error);    
          }
          return snapshot.hasData 
          ? JogadoresList(jogadores: snapshot.data)
          : Center(child: CircularProgressIndicator(),);
        },
      ),
      
    );
  }
}

class JogadoresList extends StatelessWidget {
  
  final List<Jogadores> jogadores;

  JogadoresList({Key key, this.jogadores}) : super(key: key);  

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
                Text(jogadores[index].nome == null ? 'Dados não encontrados' : jogadores[index].nome, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                Text(jogadores[index].idade == null ? 'Dados não encontrados' : 'Date: ${jogadores[index].idade}', style: TextStyle(fontSize: 16),),
                
              ],
            ),
          ),
          onTap: () {

          },
        );
      },
      itemCount: jogadores.length,
    );
  }
}
