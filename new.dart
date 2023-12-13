import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IGNote extends StatefulWidget {
  const IGNote({super.key});

  @override
  State<IGNote> createState() => _IGNoteState();
}

class _IGNoteState extends State<IGNote> {
  var listVerifiedUser = [];

  Future<void> fetchData() async {
    try {
      var response = await http.get(Uri.parse(
          'https://raw.githubusercontent.com/codermert/avatar_flutter/main/listVerifiedUser.json'));
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        setState(() {
          listVerifiedUser = jsonData;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              "Güncellemeler",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    padding: EdgeInsets.only(left: 20),
                    shrinkWrap: true,
                    itemCount: listVerifiedUser.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      final bool isVerified =
                          listVerifiedUser.elementAt(index)['verified'] ==
                              "true";

                      return Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 92,
                                  width: 92,
                                  child: Stack(
                                    children: [
                                      // Profile Picture (moved outside the if condition)
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                          listVerifiedUser
                                              .elementAt(index)['pp']!,
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Container(
                                          padding: EdgeInsets.all(0),
                                          height: 50,
                                          child: Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(19),
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Color(0xFFE9E7E7),
                                                      blurRadius: 1.0,
                                                      spreadRadius: 1.0,
                                                    ),
                                                  ],
                                                ),
                                                child: Text(
                                                  listVerifiedUser.elementAt(
                                                      index)['note']!,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 16,
                                                right: 10,
                                                child: Container(
                                                  width: 10,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                bottom: 10,
                                                right: 18,
                                                child: Container(
                                                  width: 5,
                                                  height: 5,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      listVerifiedUser
                                          .elementAt(index)['username']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                      ),
                                    ),
                                    // Additional spacing between username and badge
                                    SizedBox(width: 4),
                                    // Verification Badge
                                    if (isVerified)
                                      Icon(
                                        Icons.verified,
                                        color: Colors.blue,
                                        size: 15,
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IGNote(),
  ));
}
