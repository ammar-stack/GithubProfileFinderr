import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'showdata.dart';
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var controllerName = TextEditingController();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 2, 26, 46),
            Color.fromARGB(255, 11, 65, 109),
          ],
        )),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, bottom: 30),
          child: Center(
            child: Column(
              children: [
                const Image(image: AssetImage('assets/Igit.png')),
                Padding(
                  padding: const EdgeInsets.only(left: 35, right: 35, top: 35),
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    controller: controllerName,
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 18, 184, 250),
                        letterSpacing: 2,
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 18, 184, 250), width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 18, 184, 250), width: 1),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 10, 109, 148)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeftWithFade,
                                duration: const Duration(seconds: 1),
                                child:  ShowData(name: controllerName.text.toString())));
                        print(controllerName.text.toString());
                      },
                      child: const Text(
                        "Search",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
