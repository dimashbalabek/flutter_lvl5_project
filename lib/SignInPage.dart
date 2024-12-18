// ignore_for_file: sized_box_for_whitespace


import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/Home.dart';
import 'package:flutter_lvl5_project/RegisterPage.dart';
import 'package:flutter_lvl5_project/data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    super.initState();

    


    if (_mybox0.get("IS_LOGGED")== null) {
      _mybox0.put("IS_LOGGED", false);
    }
    if (_mybox0.get("IS_LOGGED") == true) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){ return HomePage();}));
    }
  }
  final _mybox0 = Hive.box("Box_Sign");
  final _mybox1 = Hive.box("Habit_Database");
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  User? userDataC;
  bool isEmail = false; 
  bool isPass = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey ,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(borderRadius: BorderRadius.circular(90),child: Image.asset("assets/logo.png", width: 70,)),
          
              Container(
                width: MediaQuery.of(context).size.width*0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start  ,
                  children: [
                    Text("Welcome!", style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),),
                    Text("Hi! enter your details to get sign in to your account"),
                  ],
                ),
              ),
          
              TextFormField(
                controller: _emailC,
                validator: (value) {

                  for (var i = 0; i < usersData.length; i++) {
                    if (usersData[i].email == value) {
                      isEmail = true;
                      userDataC = usersData[i];
                      print(userDataC!.name);
                      break;
                    }
                  }

                  if (value == null || value.isEmpty) {
                    return "Please enter your email at first";
                  }
                  else if(isEmail == false){
                    return "invalid email";
                  }
                  
                },
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10,))
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: _passC,
                validator: (value) {

                  for (var i = 0; i < usersData.length; i++) {
                    if (usersData[i].password == value) {
                      isPass = true;
                      break;
                    }
                  }

                  if (value == null || value.isEmpty) {
                    return "Please enter your password at first";
                  }
                  else if(isPass == false){
                    return "invalid password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10,))
                ),
              ),

              TextButton(onPressed: (){}, child: Text("Forgot Password?")),

              SizedBox(height: 80,),

              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width, 50))
                ),
onPressed: () async {
  if (_formKey.currentState!.validate()) {
    _mybox0.put("USER_NAME", userDataC!.name);
    _mybox0.put("USER_AGE", userDataC!.age);
    _mybox0.put("USER_EMAIl", userDataC!.email);
    _mybox0.put("USER_GENDER", userDataC!.gender);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Signed in successfully!"),
          backgroundColor: Color.fromARGB(255, 53, 53, 53),
          ),
         );
    _mybox0.put("IS_LOGGED", true);
    await Future.delayed(Duration(seconds: 2));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) {
            return HomePage();
          },
        ),
      );
    }
  }
},
 child: Text("Login")
              ),

              SizedBox(height: 10,),
              ElevatedButton(
                style: ButtonStyle(minimumSize: WidgetStatePropertyAll(Size(MediaQuery.of(context).size.width, 50))),
                onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context){ return RegisterPage();}));
              }, child: Text("Register")),

              SizedBox(height: 30,),

              Text("or Sign in via"),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 250, 224, 253),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: Icon(FontAwesomeIcons.apple),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 250, 224, 253),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: Icon(FontAwesomeIcons.google),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 250, 224, 253),
                    ),
                    height: 50,
                    width: MediaQuery.of(context).size.width*0.3,
                    child: Icon(FontAwesomeIcons.github, ),
                  ),
                ],
              )
            ],
          ),
        ),
        ),
    );
  }
}