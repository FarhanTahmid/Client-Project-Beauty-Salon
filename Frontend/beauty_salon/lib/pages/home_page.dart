import 'dart:convert';
import 'package:beauty_salon/backend.dart';
import 'package:beauty_salon/pages/parlour.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = '';
  String email = '';
  Future<void> getUserDetails() async {
    var response;
    String username = widget.username;
    Backend backend = Backend();
    String serverMeta = backend.backendServerMeta;
    var getUserUrl = Uri.parse("$serverMeta/api/user_details/$username");
    response = await http.get(getUserUrl);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      name = jsonResponse['name'];
      email = jsonResponse['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserDetails();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        //leading: IconButton(icon: ),

        title: Text("Beauty Salon App"),
        actions: [
          IconButton(
            icon: Icon(Icons.ballot),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.bookmark_add),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ('assets/images/8.png'),
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.pinkAccent,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  margin: EdgeInsets.zero,
                  accountName: Text(name),
                  accountEmail: Text(email),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage(
                      ('assets/images/22.jpg'),
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                },
                leading: Icon(
                  CupertinoIcons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Home",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  CupertinoIcons.profile_circled,
                  color: Colors.white,
                ),
                title: Text(
                  "About us",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(
                  CupertinoIcons.mail,
                  color: Colors.white,
                ),
                title: Text(
                  "Email us",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Parlour(
                              username: widget.username,
                            )),
                  );
                },
                leading: Icon(
                  CupertinoIcons.add_circled_solid,
                  color: Colors.white,
                ),
                title: Text(
                  "Parlours",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              ListTile(
                onTap: () {},
                title: Text(
                  "Logout",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
