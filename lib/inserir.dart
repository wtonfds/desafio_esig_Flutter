import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import './main.dart';

class Inserir extends StatefulWidget {
  @override
  _InserirState createState() => _InserirState();
}

class _InserirState extends State<Inserir> {

  TextEditingController controllerCode = new TextEditingController();
  TextEditingController controllerNome = new TextEditingController();
  TextEditingController controllerPreco = new TextEditingController();
  TextEditingController controllerQtd = new TextEditingController();

  void inserir(){
    //http usado para emulador android
    var url="http://10.0.2.2/listaitens/inserir.php";

    //http usado para emulador genymotion
    // var url="http://10.0.3.2/listaitens/inserir.php";

    http.post(url, body: {
      "CODEITEM": controllerCode.text,
      "NOME": controllerNome.text,
      "PRECO": controllerPreco.text,
      "QUANTIDADE": controllerQtd.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Inserir novo item"),
        backgroundColor: Colors.pink[50],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Nome: Não Logado"),
              accountEmail: new Text("E-mail: Não Logado"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor: Colors.pink[200],
                child: Icon(Icons.account_box, color: Colors.white,size: 50,),
              ),
            ),
            new ListTile(
                title: new Text("HOME"),
                trailing: new Icon(Icons.home),
                onTap: (){
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (
                              BuildContext context
                              )=> new MyHomePage()
                      )
                  );
                }
            ),
            new ListTile(
              title: new Text("FECHAR"),
              trailing: new Icon(Icons.close),
              onTap: (){
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            new Column(
              children: <Widget>[
                new Padding(padding: const EdgeInsets.all(30.0)),
                new TextField(
                  controller: controllerCode,
                  decoration: new InputDecoration(
                      hintText: "Cod. Item", labelText: "Cod. Item",
                      border: OutlineInputBorder(),
                   ),
                ),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new TextField(
                  controller: controllerNome,
                  decoration:
                      new InputDecoration(
                        hintText: "Nome", labelText: "Nome",
                        border: OutlineInputBorder(),
                      ),
                ),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new TextField(
                  controller: controllerPreco,
                  decoration: new InputDecoration(
                    hintText: "Preço", labelText: "Preço",
                    border: OutlineInputBorder(),

                  ),
                ),
                new Padding(padding: const EdgeInsets.all(5.0)),
                new TextField(
                  controller: controllerQtd,
                  decoration: new InputDecoration(
                    hintText: "Quantidade", labelText: "Quantidade",
                    border: OutlineInputBorder(),
                  ),
                ),
                new Padding(padding: const EdgeInsets.all(80.0)),
                new Row(
                  mainAxisSize: MainAxisSize.min,

                  children: <Widget>[
                    new FlatButton(
                      child: new Text("APAGAR", style: new TextStyle(color: Colors.black),),
                      onPressed: (){
                        controllerCode.clear();
                        controllerNome.clear();
                        controllerPreco.clear();
                        controllerQtd.clear();
                      },),
                    Padding(padding: const EdgeInsets.only(left: 30)),

                    new RaisedButton(
                      child: new Text("SALVAR", style: new TextStyle(color: Colors.black),),
                      elevation: 8.0,
                      shape: BeveledRectangleBorder(
                          borderRadius: new BorderRadius.circular(2.0)),
                      color: Colors.pink[50],
                      onPressed: () {
                        inserir();
                        Navigator.pop(context);
                      },
                    )
                  ],
                )



              ],
            ),
          ],
        ),
      ),
    );
  }
}
