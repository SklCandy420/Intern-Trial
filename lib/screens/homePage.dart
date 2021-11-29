import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/imgPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> data;
  String _search = "nature";

  @override
  void initState() {
    // TODO: implement initState
    getJsonData();
    super.initState();
  }

  Future<String> getJsonData() async {
    try {
      var response = await http.get(
          'https://api.unsplash.com/search/photos?per_page=40&client_id=38QIqc_I4YyaYCTlhbbLgFNne4MD8uPQVrlqWIMrfww&query=$_search');
      setState(() {
        var converted = json.decode(response.body);
        data = converted['results'];
      });
      return "Success";
    } catch (e) {
      return e.toString();
    }
  }

  Icon cusicon = Icon(Icons.search);
  Widget custext = Text("Test");
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {},
              tooltip: 'menu',
              icon: Icon(Icons.menu),
            ),
            title: custext,
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  setState(() {
                    if (this.cusicon.icon == Icons.search) {
                      this.cusicon = Icon(Icons.cancel);
                      this.custext = TextField(
                        autofocus: true,
                        onChanged: (text) {
                          setState(() {
                            _search = text;
                          });
                          getJsonData();
                        },
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search Here",
                            hintStyle: TextStyle(
                              color: Colors.white,
                            )),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      );
                    } else {
                      this.cusicon = Icon(Icons.search);
                      this.custext = Text('Test');
                    }
                  });
                },
                icon: cusicon,
              )
            ],
          ),
          body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      new Card(
                        child: new Container(
                          padding: EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ImgPage(data[index])));
                                },
                                child: Image.network(
                                  data[index]['urls']['small'],
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
