// ignore_for_file: prefer_const_constructors

import 'package:apiss/model/makemodel.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Welcome>> fetchPosts() async {
  var url = Uri.parse(
      'https://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => Welcome.fromJson(data)).toList();
  } else {
    throw Exception("Unexpected Result");
  }
}

class HttpClass extends StatefulWidget {
  const HttpClass({Key? key}) : super(key: key);

  @override
  State<HttpClass> createState() => _HttpClassState();
}

class _HttpClassState extends State<HttpClass> {
  late Future<List<Welcome>> postData;
  @override
  void initState() {
    super.initState();
    postData = fetchPosts();
    debugPrint("Post data is ${postData.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("http exapmle"),
      ),
      body: Center(
        child: FutureBuilder<List<Welcome>>(
          future: postData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Welcome>? posts = snapshot.data;
              return ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Card(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              trailing: Text(posts![index].id.toString()),
                              title: Text(posts![index].brand.toString()),
                              subtitle: Text(posts![index].name),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                (posts![index].imageLink),
                              )),

                              // CircleAvatar(
                              //   backgroundImage:
                              //       NetworkImage("https://picsum.photos/200/"),
                              // ),
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
