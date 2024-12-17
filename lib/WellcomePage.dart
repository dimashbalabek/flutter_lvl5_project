import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/Home.dart';
import 'package:flutter_lvl5_project/SignInPage.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:hive/hive.dart';

final _mybox0 = Hive.box("Box_Sign");

class WelcomePage extends StatefulWidget {
  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool? isLogged;

  @override
  void initState() {
    super.initState();
    isLogged = _mybox0.get("IS_LOGGED", defaultValue: false);
    if (isLogged ?? false) {
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLogged == null) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: isLogged!
          ? Center(child: Image.asset("assets/logo.png", width: 150,))
          : 
          IntroductionScreen(
              pages: [
                PageViewModel(
                  title: "Habits Tracker App",
                  bodyWidget: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/wellcome(1).png",
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),
                          Text(
                            "Сollect points and achievements. Mark the completion of tasks every day.",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PageViewModel(
                  title: "Habits Tracker App",
                  bodyWidget: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/wellcome(2).png",
                            width: MediaQuery.of(context).size.width * 0.67,
                          ),
                          Text(
                            "We will help you to reach your achievements!",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              onDone: () => _goToNextPage(context),
              onSkip: () => _goToNextPage(context),
              showSkipButton: true,
              skip: const Text("Skip"),
              next: const Icon(Icons.arrow_forward),
              done: const Text("Done", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
    );
  }

  void _goToNextPage(BuildContext context) {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => SignInPage(),
      ),
    );
  }
}
