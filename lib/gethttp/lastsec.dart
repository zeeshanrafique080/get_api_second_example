import 'dart:convert';
import 'dart:math';

import 'package:apiss/model/dummy.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class LastExampleScreen extends StatefulWidget {
  const LastExampleScreen({Key? key}) : super(key: key);

  @override
  _LastExampleScreenState createState() => _LastExampleScreenState();
}

class _LastExampleScreenState extends State<LastExampleScreen> {
  Future<Dumy> getProductsApi() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/user'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return Dumy.fromJson(data);
    } else {
      return Dumy.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Dumy jasson'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<Dumy>(
                future: getProductsApi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.users!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                trailing: Text(snapshot
                                    .data!.users![index].phone
                                    .toString()),
                                title: Text(snapshot
                                    .data!.users![index].firstName
                                    .toString()),
                                subtitle: Text(snapshot
                                    .data!.users![index].hair!.color
                                    .toString()),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(snapshot
                                      .data!.users![index].image
                                      .toString()),
                                ),
                              ),
                              // Container(
                              //   height: MediaQuery.of(context).size.height *.3,
                              //   width: MediaQuery.of(context).size.width * 1,
                              //   child: ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: snapshot.data!.data![index].images!.length,
                              //       itemBuilder: (context, position){
                              //     return Padding(
                              //       padding: const EdgeInsets.only(right: 10),
                              //       child: Container(
                              //         height: MediaQuery.of(context).size.height *.25,
                              //         width: MediaQuery.of(context).size.width * .5,
                              //         decoration: BoxDecoration(
                              //           borderRadius: BorderRadius.circular(10),
                              //           image: DecorationImage(
                              //             fit: BoxFit.cover,
                              //             image: NetworkImage(snapshot.data!.data![index].images![position].url.toString())
                              //           )
                              //         ),
                              //       ),
                              //     );
                              //   }),
                              // ),
                              // Icon(snapshot.data!.data![index].inWishlist! == false ? Icons.favorite : Icons.favorite_outline)
                            ],
                          );
                        });
                  } else {
                    return Text('Loading');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
