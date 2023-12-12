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

  String myNote = "";
  TextEditingController noteController = TextEditingController();

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
              "codermert",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
        actions: [
          Icon(
            Icons.more_horiz,
            size: 24,
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            UniconsLine.edit,
            size: 24,
          ),
          SizedBox(
            width: 15,
          ),
        ],
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
                          Visibility(
                            visible: index == 0,
                            child: Container(
                              margin: EdgeInsets.only(right: 18),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 92,
                                    width: 92,
                                    // color: Colors.white,
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.white,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network(
                                              "https://res.cloudinary.com/divijw2qz/image/upload/w_350,h_350,c_fill,r_max/WhatsApp_Image_2023-11-30_at_18.37.20.jpg",
                                            ),
                                          ),
                                        ),
                                        myNote.isEmpty
                                            ? Align(
                                                alignment: Alignment.topRight,
                                                child: GestureDetector(
                                                  onTap: () {
                                                    modalSetNote();
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.all(2),
                                                    // width: 50,
                                                    height: 45,
                                                    child: Stack(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0xFFD6D5D5),
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    1.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Icon(
                                                            Icons.add,
                                                            color: Color(
                                                                0xFF5F5F5F),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 8,
                                                          left: 9,
                                                          child: Container(
                                                            width: 10,
                                                            height: 10,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 4,
                                                          left: 6,
                                                          child: Container(
                                                            width: 5,
                                                            height: 5,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          50),
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Align(
                                                alignment:
                                                    Alignment.bottomCenter,
                                                child: Container(
                                                  height: 58,
                                                  child: Stack(
                                                    children: [
                                                      Align(
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(4),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        14),
                                                            color: Colors.white,
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Color(
                                                                    0xFFE9E7E7),
                                                                blurRadius: 1.0,
                                                                spreadRadius:
                                                                    1.0,
                                                              ),
                                                            ],
                                                          ),
                                                          child: Text(
                                                            myNote,
                                                            maxLines: 3,
                                                            style: TextStyle(
                                                              fontSize: 10,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 20,
                                                        right: 12,
                                                        child: Container(
                                                          width: 10,
                                                          height: 10,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                      Positioned(
                                                        top: 16,
                                                        right: 20,
                                                        child: Container(
                                                          width: 5,
                                                          height: 5,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50),
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Notunuz",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                                      Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        padding: EdgeInsets.all(8),
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
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            modalSetNote();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(2),
                                            // width: 50,
                                            height: 45,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14),
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xFFE9E7E7),
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
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  listVerifiedUser
                                      .elementAt(index)['username']!,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  modalSetNote() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // title: const Text('Basic dialog title'),
          actionsAlignment: MainAxisAlignment.center,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Your Note'),
              TextFormField(
                controller: noteController,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 5,
                decoration: InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.all(5),
                  fillColor: Colors.grey,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Save'),
              onPressed: () {
                setState(() {
                  myNote = noteController.text;
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: IGNote(),
  ));
}
