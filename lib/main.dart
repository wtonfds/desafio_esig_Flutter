import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import './detail.dart';
import './inserir.dart';

void main() => runApp(MyApp());

final ThemeData _themeData = new ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.pink[50],
  accentColor: Colors.pinkAccent,

);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gerenciador de Itens',
      theme: _themeData,
      home: MyHomePage(title: 'Gerenciador de Itens Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List> getData() async {
    // http usado para emulador android studio
    final response = await http.get("http://10.0.2.2/listaitens/getdata.php");

    // http usando para emulador genymotion
    //final response = await http.get("http://10.0.3.2/listaitens/getdata.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text("Gerenciador de Itens"),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: ()=> Navigator.of(context).push(
            new MaterialPageRoute(builder: (BuildContext context)=> new Inserir(),
            )
          ),
        ),
      body: new FutureBuilder<List>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) print(snapshot.error);

            return snapshot.hasData
                ? new ListItem(
                    list: snapshot.data,
                  )
                : new Center(
                    child: new CircularProgressIndicator(),
                  );
          },
        ),
      );
  }
}

class ListItem extends StatelessWidget {
  final List list;
  ListItem({this.list});

  @override
  Widget build(BuildContext context) {

    return new ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i) {
        return new Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          padding: const EdgeInsets.all(10.0),
          child: new GestureDetector(
            onTap: () => Navigator.of(context).push(
                  new MaterialPageRoute(
                      builder: (BuildContext context) => new Detail(
                            list: list,
                            index: i,
                          )),
                ),
            child: new Card(
              child: new ListTile(
                title: new Text(list[i]['NOME']),
                leading: new Icon(
                  Icons.next_week,
                  color: Colors.pink[200],
                ),
                subtitle: new Text("Quantidade: ${list[i]['QUANTIDADE']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}
