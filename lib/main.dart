import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_list/Person.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _navIndex = 0;
  bool _isLoading = false;
  List<Person> _data;
  List<String> cats = [
    "assets/cat0.jpg",
    "assets/cat1.jpg",
    "assets/cat2.jpg",
    "assets/cat3.jpg",
    "assets/cat4.jpg",
    "assets/cat5.jpg",
    "assets/cat6.jpg",
    "assets/cat7.jpg",
    "assets/cat8.jpg",
    "assets/cat9.jpg",
  ];

  @override
  void initState() {
    super.initState();
    loadPeople();
  }

  void loadPeople() async {
    setState(() {
      _isLoading = true;
    });
    List<Person> res;
    try {
      final response = await http.get(
          Uri.parse("https://randomuser.me/api/?results=1000&nat=de&noinfo"));
      if (response.statusCode == 200) {
        res = [];
        for (var person in jsonDecode(response.body)['results'])
          res.add(Person.fromMap(person));
      } else {
        throw Exception(
            'Failed to load people - ${response.statusCode} - ${response.toString()}');
      }
    } catch (e) {
      throw Exception('Failed to load people - ${e.toString()}');
    }
    setState(() {
      _isLoading = false;
      _data = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_navIndex == 1) cats.shuffle();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _navIndex == 0 ? "Internet Daten" : "Lokale Daten",
        ),
      ),
      body: _navIndex == 0
          ? _data != null && _isLoading == false
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.refresh),
                          onPressed: () {
                            loadPeople();
                          },
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            Person item = _data[index];
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "${item.firstName} ${item.lastName}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    item.userName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w300,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Image.network(
                                          item.pictureUrl,
                                          height: 80,
                                          width: 100,
                                        ),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            "${item.streetName} ${item.streetNumber}",
                                          ),
                                          Text(
                                            "${item.postCode}, ${item.city}",
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                )
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {});
                      },
                    ),
                  ],
                ),
                Expanded(
                  child: GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    children: cats
                        .map<Widget>(
                          (e) => Image.asset(
                            e,
                            height: 200,
                            width: 150,
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            _navIndex = value;
          });
        },
        currentIndex: _navIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.wifi),
            label: 'Internet Daten',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: 'Lokale Daten',
          ),
        ],
      ),
    );
  }
}
