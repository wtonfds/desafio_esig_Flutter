import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './editar.dart';
import './main.dart';

class Detail extends StatefulWidget {
  final List list;
  final int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  void deletar() {
    // http usado para emulador android estudio
    var url = "http://10.0.2.2/listaitens/deletar.php";

    // http usado para emulador genymotion
    // var url="http://10.0.3.2/listaitens/deletar.php";
    http.post(url, body: {'ID': widget.list[widget.index]['ID']});
  }

  void confirmar() {
    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        "Você tem certeza que deseja deletar '${widget.list[widget.index]['NOME']}' ?",
        style: new TextStyle(
            fontSize: 20, fontFamily: "Arial", fontWeight: FontWeight.bold),
      ),
      actions: <Widget>[
        new FlatButton(
          child: new Text(
            "DELETAR",
            style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.5)),
          onPressed: () {
            deletar();
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => new MyHomePage(),
            ));
          },
        ),
        new FlatButton(
          child: new Text(
            "CANCELAR",
            style: new TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          shape:
              BeveledRectangleBorder(borderRadius: BorderRadius.circular(2.5)),
          onPressed: () => Navigator.pop(context),
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("${widget.list[widget.index]['NOME']}"),
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
      body: new Container(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 150),
                ),
                new Text(
                  widget.list[widget.index]['NOME'],
                  style: new TextStyle(
                      fontFamily: "Georgia",
                      fontSize: 32,
                      fontWeight: FontWeight.w100),
                ),
                new Text(
                  "Cod. Item : ${widget.list[widget.index]['CODEITEM']}",
                  style: new TextStyle(
                      fontFamily: "Georgia",
                      fontSize: 30,
                      fontWeight: FontWeight.w100),
                ),
                new Text(
                  "Preço : ${widget.list[widget.index]['PRECO']}",
                  style: new TextStyle(
                      fontFamily: "Georgia",
                      fontSize: 30,
                      fontWeight: FontWeight.w100),
                ),
                new Text(
                  "Quantidade : ${widget.list[widget.index]['QUANTIDADE']}",
                  style: new TextStyle(
                      fontFamily: "Georgia",
                      fontSize: 30,
                      fontWeight: FontWeight.w100),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 170),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    new FlatButton(
                      child: new Text(
                        'DELETAR',
                        style: new TextStyle(color: Colors.black),
                      ),
                      onPressed: () => confirmar(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                    ),
                    new RaisedButton(
                      child: new Text(
                        'EDITAR',
                        style: new TextStyle(color: Colors.black),
                      ),
                      elevation: 8.0,
                      shape: BeveledRectangleBorder(
                          borderRadius: new BorderRadius.circular(2.5)),
                      color: Colors.pink[50],
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => new Editar(
                                  list: widget.list,
                                  index: widget.index,
                                ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
