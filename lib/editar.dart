import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import './main.dart';

class Editar extends StatefulWidget {



  final List list;
  final int index;
  Editar ({this.index, this.list});

  @override
  _EditarState createState() => _EditarState();
}

class _EditarState extends State<Editar> {

  TextEditingController controllerCode;
  TextEditingController controllerNome;
  TextEditingController controllerPreco;
  TextEditingController controllerQtd;

  void editar(){
    // http usado para emulador android studio
    var url="http://10.0.2.2/listaitens/editar.php";

    // http usado para emulador genymotion
    //var url="http://10.0.2.2/listaitens/editar.php";

    http.post(url, body: {
      "ID": widget.list[widget.index]['ID'],
      "CODEITEM": controllerCode.text,
      "NOME": controllerNome.text,
      "PRECO": controllerPreco.text,
      "QUANTIDADE": controllerQtd.text,
    });

  }

  @override
  void initState() {
    controllerCode = new TextEditingController(text: widget.list[widget.index]['CODEITEM']);
    controllerNome = new TextEditingController(text: widget.list[widget.index]['NOME']);
    controllerPreco = new TextEditingController(text: widget.list[widget.index]['PRECO']);
    controllerQtd = new TextEditingController(text: widget.list[widget.index]['QUANTIDADE']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Editar "+"${widget.list[widget.index]['NOME']}"),
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
                new RaisedButton(
                  child: new Text("SALVAR"),
                  elevation: 8.0,
                  shape: BeveledRectangleBorder(
                      borderRadius: new BorderRadius.circular(2.0)),
                  color: Colors.pink[50],
                  onPressed: () {
                    editar();
                    Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (
                          BuildContext context
                          )=> new MyHomePage()
                      )
                    );
                  },
                ),
                new Padding(padding: const EdgeInsets.only(right: 30))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
