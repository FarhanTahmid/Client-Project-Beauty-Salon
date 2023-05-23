import 'package:flutter/material.dart';
import 'package:beauty_salon/backend.dart';
import 'package:beauty_salon/pages/bookParlorPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Parlour extends StatefulWidget {
  const Parlour({Key? key}) : super(key: key);

  @override
  State<Parlour> createState() => _ParlourState();
}

class _ParlourState extends State<Parlour> {
  final List<String> salonNames = [];
  final List<String> salonIds = [];
  final List<String> salonMotto = [];
  final List<String> saloncontactNo = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    getRegisteredParlors();
  }

  Future<void> getRegisteredParlors() async {
    Backend backend = Backend();
    String serverMeta = backend.backendServerMeta;
    var getSalonsUrl = Uri.parse('$serverMeta/api/beautysalons');
    var response = await http.get(getSalonsUrl);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);

      setState(() {
        salonNames.clear();
        salonIds.clear();
        salonMotto.clear();
        saloncontactNo.clear();

        jsonResponse['name'].forEach((key, value) {
          salonNames.add(value);
        });
        jsonResponse['name'].forEach((key, value) {
          salonIds.add(key);
        });

        jsonResponse['motto'].forEach((key, value) {
          salonMotto.add(value);
        });

        jsonResponse['contact'].forEach((key, value) {
          saloncontactNo.add(value);
        });
      });
    }
  }

  List<String> filterSalonNames(String query) {
    return salonNames
        .where((name) => name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredSalonNames = filterSalonNames(searchQuery);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreenAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Beauty Salons"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                salonNames.clear();
                salonIds.clear();
                salonMotto.clear();
                saloncontactNo.clear();
              });
              getRegisteredParlors();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredSalonNames.length,
              itemBuilder: (context, index) {
                final salonName = filteredSalonNames[index];
                final salonIndex = salonNames.indexOf(salonName);

                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(Icons.supervised_user_circle_outlined),
                  ),
                  title: Text(salonName),
                  subtitle: Text(salonMotto[salonIndex]),
                  trailing: Icon(Icons.ring_volume),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookingPage(
                          parlorPrimaryKey: salonIds[salonIndex],
                        ),
                      ),
                    );
                  },
                  tileColor: Colors.brown.shade50,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

