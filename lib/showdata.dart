import 'dart:convert';
import 'package:rive/rive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ShowData extends StatefulWidget {
  final String name;
  ShowData({super.key, required this.name});

  @override
  State<ShowData> createState() => _ShowDataState();
}

class _ShowDataState extends State<ShowData> {
  Future<Map<String, dynamic>> fetchData() async {
    final response = await http
        .get(Uri.parse("https://api.github.com/users/${widget.name}"));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to load data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: RiveAnimation.asset('assets/new_file.riv'));
            }
            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else {
              var userData = snapshot.data!;
              return Container(
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 2, 26, 46)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        maxRadius: 75,
                        minRadius: 75,
                        backgroundImage:
                            NetworkImage('${snapshot.data?['avatar_url']}'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 30),
                        child: Container(
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 211, 209, 209),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Repositories",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text('${userData['public_repos']}',
                                        style: const TextStyle(fontSize: 18))
                                  ],
                                ),
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text("Hireable",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                    Text('${userData['hireable'] ?? '0'}',
                                        style: const TextStyle(fontSize: 18))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 25, horizontal: 30),
                        child: Container(
                          height: 330,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 211, 209, 209),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Username: ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${userData['login']}",
                                          style: const TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 25),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Name: ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${userData['name']}",
                                          style: const TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 25),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Location: ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text("${userData['location']}",
                                          style: const TextStyle(fontSize: 20))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 25),
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Bio: ",
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Expanded(
                                        child: Text(
                                          "${userData['bio']??'no bio'}",
                                          style: const TextStyle(fontSize: 20),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 5,
                                        ),
                                      )
                                    ],
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
              );
            }
          }),
    );
  }
}
