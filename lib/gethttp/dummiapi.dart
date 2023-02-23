// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:apiss/gethttp/http.dart';
import 'package:apiss/gethttp/lastsec.dart';
import 'package:apiss/model/fakeapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:http/http.dart' as http;

// class User {
//   final String id;
//   final String name;
//   final String email;
//   final String address;
//   final String phone;

//   User({ required this.id,required this.name, required this.email,required this.address, required this.phone});

//   factory User.fromJson(Map<String, dynamic> json) {
//     return User(
//       id: json['id'],
//       name: json['name'],
//       email: json['email'],
//       address: json['address'],
//       phone: json['phone'],
//     );
//   }
// }

// Future<List<User>> fetchUsers() async {
//   final response = await http.get(Uri.parse('https://dummyjson.com/user'));

//   if (response.statusCode == 200) {
//     print("data loaded");
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     List<dynamic> data = json.decode(response.body)['data'];
//     return data.map((user) => User.fromJson(user)).toList();
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load users');
//   }
// }

// 2nd

List<Fake> userList = [];

Future<List<Fake>> getUserApi() async {
  final response =
      await http.get(Uri.parse('https://fakestoreapi.com/products'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    print("data loaded");
    for (var i in data) {
      userList.add(Fake.fromJson(i));
    }
    return userList;
  } else {
    return userList;
  }
}

// Future<Album> fetchAlbum() async {
//   final response = await http
//       .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Album.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }

// class Api extends StatefulWidget {
//   const Api({Key? key}) : super(key: key);

//   @override
//   State<Api> createState() => _ApiState();
// }

// class _ApiState extends State<Api> {
//   late Future<List<User>> postData;

//   @override
//   void initState() {
//     super.initState();
//     postData = fetchUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<List<User>>(
//             future: postData,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 List<User>? posts = snapshot.data;
//                 return ListView.builder(
//                   itemCount: posts?.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       margin: EdgeInsets.all(5),
//                       child: Card(
//                         child: Container(
//                           padding: EdgeInsets.all(8),
//                           child: Column(
//                             children: [
//                               Text("data loading"),
//                               ListTile(
//                                 trailing:
//                                     Text(posts![index].firstName.toString()),
//                                 title: Text(posts[index].age.toString()),
//                                 // subtitle:
//                                 //     Text(posts![index].bloodGroup.toString()),
//                                 leading: CircleAvatar(
//                                   backgroundImage: NetworkImage(
//                                       "https://picsum.photos/200/"),
//                                 ),
//                                 onTap: () {
//                                   // Navigator.push(context,
//                                   //     MaterialPageRoute(builder: (builder) {
//                                   //   return PostDetails(posts[index]);
//                                   // }));
//                                 },
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               } else if (snapshot.hasError) {
//                 return Text("${snapshot.error}");
//               }
//               return CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

class ExampleThree extends StatefulWidget {
  const ExampleThree({Key? key}) : super(key: key);

  @override
  _ExampleThreeState createState() => _ExampleThreeState();
}

class _ExampleThreeState extends State<ExampleThree> {
  @override
  Widget build(BuildContext context) {
    print('hello');
    print(userList);

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HttpClass()));
              },
              title: Text("Fake Api"),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => LastExampleScreen()));
              },
              title: Text("DumyJason Api"),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Api Course'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getUserApi(),
              builder: (context, AsyncSnapshot<List<Fake>> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  ListTile(
                                    trailing: Image.network(
                                        snapshot.data![index].image.toString()),
                                    subtitle: Text(
                                        snapshot.data![index].price.toString())
                                    //         .toString()),
                                    ,
                                    title: Text(
                                        "name: ${snapshot.data![index].title.toString()}   "),
                                  ),
                                  // ReusbaleRow(
                                  //     title: 'Name',
                                  //     value: snapshot.data![index].title
                                  //         .toString()),

                                  //         ReusbaleRow(
                                  //     title: 'Address',
                                  //     value: snapshot.data![index].brand
                                  //         .toString()),
                                  //         ReusbaleRow(
                                  //     title: 'Address',
                                  //     value: snapshot.data![index].description
                                  //         .toString()),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class ReusbaleRow extends StatelessWidget {
  String title, value;
  ReusbaleRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}
