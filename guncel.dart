import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui';

class EnlargedProfilePicture extends StatelessWidget {
  final String imageUrl;
  final String fullName;

  EnlargedProfilePicture({required this.imageUrl, required this.fullName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blurred background
          Positioned.fill(
            child: Image.network(
              "https://res.cloudinary.com/divijw2qz/image/upload/v1702489912/pexels-photo-1242348.jpg",
              fit: BoxFit.cover,
            ),
          ),
          // BackdropFilter to create a blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          // Content in the center
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  fullName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EnlargedProfilePicture(
                                    imageUrl: listVerifiedUser
                                        .elementAt(index)['pp']!,
                                    fullName: listVerifiedUser
                                        .elementAt(index)['fullname']!,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 99,
                                    width: 99,
                                    child: Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xffFF7E5F),
                                                Color(0xffD4A5A5),
                                                Color(0xff5D5E6B),
                                                Color(0xff6D73B5),
                                              ],
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                            ),
                                          ),
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: Colors.white,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              child: Image.network(
                                                listVerifiedUser
                                                    .elementAt(index)['pp']!,
                                              ),
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
                                      SizedBox(width: 4),
                                      if (listVerifiedUser
                                              .elementAt(index)['verified'] ==
                                          "true")
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
