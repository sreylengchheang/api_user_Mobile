import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  List user;
  //future when we request data from api we don't know data get or not get show we function Future
 Map datas;
  Future setUser() async {
    // String url = "https://jsonplaceholder.typicode.com/users";
    String url = "https://reqres.in/api/users";
    http.Response response = await http.get(url);
    //print in console
    // debugPrint(response.body);
    //setState when we refers it will change data
    datas = json.decode(response.body);
    setState(() {
      // user = json.decode(response.body);
      user = datas['data'];
    });
  }

  @override
  void initState() {
    super.initState();
    setUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User information"),
        backgroundColor: Colors.red,
      ),
      //ListView.builder is meaning loop to display data on interface like list
      body: ListView.builder(
        //buid array to display all array in content
          itemCount: user == null ? 0 : user.length,
          //display all context to interface
          itemBuilder: (BuildContext context, int i) {
            return Card(
              // child: Text("${user[i]["name"]}"),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage("${user[i]["avatar"]}"),
                    ),
                    Text("${user[i]["first_name"]}"),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
