import 'dart:html';

import 'package:flutter/material.dart';
class Parlour extends StatefulWidget {
  const Parlour({super.key});

  @override
  State<Parlour> createState() => _ParlourState();
}

class  _ParlourState extends State<Parlour> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        leading: IconButton(icon: Icon(Icons.holiday_village), onPressed: () {
          
        }, ),
        title: Text("Beauty Salons"),
        actions: [
          //IconButton(icon: Icon(Icons.call), onPressed: () {},),
          IconButton(icon: Icon(Icons.search), onPressed: () {},),
          //IconButton(icon: Icon(Icons.video_chat_sharp), onPressed: () {},),
        ],

      ),
      body: Container(
        child: ListView(
          itemExtent: 100.0,
          children: [
            ListTile(
              leading: CircleAvatar(child: (Icon(Icons.supervised_user_circle_outlined))),
              title: Text("Queens"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {
                Navigator.pushNamed(context, 'queens');
              },
              tileColor: Colors.brown.shade50,
            
          ),
            ListTile(
              leading: CircleAvatar(child: (Icon(Icons.kayaking))),
              title: Text("Sassy"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {
                Navigator.pushNamed(context, 'sassy');
              },
              tileColor: Colors.brown.shade50,
            
          ),
            
             ListTile(
              leading: CircleAvatar(child: (Icon(Icons.kitesurfing))),
              title: Text("Beauty World"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {
                Navigator.pushNamed(context, 'beautyworld');
              },
              tileColor: Colors.brown.shade50,
            
          ),
             ListTile(
              leading: CircleAvatar(child: (Icon(Icons.woman_rounded))),
              title: Text("Zara Salon"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {},
              tileColor: Colors.brown.shade50,
            
          ),
          ListTile(
              leading: CircleAvatar(child: (Icon(Icons.woman_2))),
              title: Text("Lorial"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {},
              tileColor: Colors.brown.shade50,
            
          ),
          ListTile(
              leading: CircleAvatar(child: (Icon(Icons.sailing))),
              title: Text("Persona"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {},
              tileColor: Colors.brown.shade50,
            
          ),
          ListTile(
              leading: CircleAvatar(child: (Icon(Icons.girl_rounded))),
              title: Text("Bioxin"),
              subtitle: Text("Beauty is our right"),
              trailing: Icon(Icons.ring_volume),
              onTap: () {},
              tileColor: Colors.brown.shade50,
            
          ),
           
          ],
        ),

      ),
    );
  }
}