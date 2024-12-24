import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/Home.dart';
import 'package:flutter_lvl5_project/RegisterPage.dart';
import 'package:flutter_lvl5_project/data.dart';
import 'package:hive/hive.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late Box _mybox0;  
  bool _isObscure = true;
  final _formKey = GlobalKey<FormState>();
  final _emailC = TextEditingController();
  final _passC = TextEditingController();
  User? userDataC;
  bool isEmail = false;
  bool isPass = false;

  @override
  void initState() {
    super.initState();
    _mybox0 = Hive.box("Box_Sign");
    
    if (_mybox0.get("IS_LOGGED") == null) {
      _mybox0.put("IS_LOGGED", false);
    }
    if (_mybox0.get("IS_LOGGED") == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return HomePage();
          }),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: Image.asset("assets/logo.png", width: 70),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome!",
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                    ),
                    Text("Hi! Enter your details to sign in to your account"),
                    SizedBox(height: 14),
                  ],
                ),
              ),
              TextFormField(
                controller: _emailC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email first";
                  }

                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return "Invalid email format";
                  }

                  isEmail = false;  
                  for (var user in usersData) {
                    if (user.email == value) {
                      isEmail = true;
                      userDataC = user;
                      break;
                    }
                  }

                  if (!isEmail) {
                    return "Email not found";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _passC,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  }

                  if (userDataC == null) {
                    return "Please enter a valid email first";
                  }

                  if (value != userDataC!.password) {
                    return "Incorrect password";
                  }
                  return null;
                },
                obscureText: _isObscure,
                decoration: InputDecoration(
                  labelText: "Enter your password",
                  prefixIcon: Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              TextButton(onPressed: () {}, child: Text("Forgot Password?")),
              SizedBox(height: 80),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (userDataC != null) {
                      _mybox0.put("USER_NAME", userDataC!.name);
                      _mybox0.put("USER_AGE", userDataC!.age);
                      _mybox0.put("USER_EMAIL", userDataC!.email);
                      _mybox0.put("USER_GENDER", userDataC!.gender);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Signed in successfully!"),
                          backgroundColor: Color.fromARGB(255, 53, 53, 53),
                        ),
                      );

                      _mybox0.put("IS_LOGGED", true);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return HomePage();
                        }),
                      );
                    }
                  }
                },
                child: Text("Login"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width, 50)),
                ),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
                    return RegisterPage();
                  }));
                },
                child: Text("Register"),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
