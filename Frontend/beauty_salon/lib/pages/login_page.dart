import 'package:beauty_salon/backend.dart';
import 'package:beauty_salon/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:beauty_salon/pages/home_page.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  String username = '';

  void createLoginCredentialFile(String user) {
    File file = File('login.txt');
    file.createSync();
    String content = user;
    file.writeAsStringSync(content);
  }

  void login() async {
    Backend backend = Backend();
    String backendMeta = backend.backendServerMeta;
    final String loginUrl = "$backendMeta/api/login";

    try {
      var response = await http.post(Uri.parse(loginUrl), body: {
        'username': usernameController.text.trim(),
        'password': passwordController.text.trim()
      });
      if (response.statusCode == 202) {
        var jsonResponse = jsonDecode(response.body);
        username = jsonResponse['username'];
        
        if (Platform.isAndroid) {
          Fluttertoast.showToast(
            msg: "User Loggedin Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (Platform.isWindows) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("User Loggedin Successfully"),
          ));
        }
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomePage(
                    username: username,
                  )),
        );
      } else if (response.statusCode == 401) {
        if (Platform.isAndroid) {
          Fluttertoast.showToast(
            msg: "Wrong Credentials! Try again.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey[700],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else if (Platform.isWindows) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Wrong Credentials! Try again."),
          ));
        }
      }
    } catch (e) {
      print(e);
      if (Platform.isAndroid) {
        Fluttertoast.showToast(
          msg: "Please check your network connection and Try again!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else if (Platform.isWindows) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("This username already exists! Try logging in"),
        ));
      }
    }
  }

  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/a.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(),
            Container(
              padding: EdgeInsets.only(left: 25, top: 100),
              child: Text(
                'Welcome\nBack',
                style: TextStyle(color: Colors.white, fontSize: 31),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          TextField(
                            controller: usernameController,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Username",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextField(
                            controller: passwordController,
                            style: TextStyle(),
                            obscureText: true,
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Password",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Sign in',
                                style: TextStyle(
                                    fontSize: 27, fontWeight: FontWeight.w700),
                              ),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.black,
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: login,
                                    icon: Icon(
                                      Icons.arrow_forward,
                                    )),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyRegister()),
                                  );
                                },
                                child: Text(
                                  'Sign up',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18),
                                ),
                                style: ButtonStyle(),
                              ),
                              TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
