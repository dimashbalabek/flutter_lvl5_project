
import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/Home.dart';
import 'package:flutter_lvl5_project/data.dart';
import 'package:hive/hive.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

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
  final _formKey = GlobalKey<FormState>();
  final _age = TextEditingController();
  final _name = TextEditingController();
  final _gender = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _phone = TextEditingController();
  List genderList = ["Male", "Female"];
  bool isMale = true;
  String gender = 'Male';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Text("Registration"),
                    Image.asset("assets/logo.png", width: 100,)
                  ],
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                keyboardType: TextInputType.name,
                controller: _name,
                validator: (_name) {
                  if (_name == null || _name.isEmpty) {
                    return "please enter your name";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  )
                ),
              ),
              Text("Example Dimash Balabek"),

              TextFormField(
                keyboardType: TextInputType.number,
                controller: _age,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your Age";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Age",
                  prefixIcon: Icon(Icons.calendar_month),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  )
                ),
              ),


SizedBox(
  width: MediaQuery.of(context).size.width *0.6, // Full width of the screen
  child: DropdownButton<String>(
    isExpanded: true,  // Expands to take the entire width
    icon: isMale ? Icon(Icons.male) : Icon(Icons.female),
    value: gender,
    items: [
      DropdownMenuItem(
        child: Text(genderList[0]),
        value: genderList[0],
      ),
      DropdownMenuItem(
        child: Text(genderList[1]),
        value: genderList[1],
      ),
    ],
    onChanged: (String? newValue) {
      setState(() {
        isMale = newValue == genderList[1] ? false : true;
        gender = newValue!;
      });
    },
  ),
),


                SizedBox(height: 10,),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _email,
                validator: (value) {
                  
                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  }

                  
                  if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
                    return "Invalid email format";
                    }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  )
                ),
              ),
              SizedBox(height: 10,),

              TextFormField(
                controller: _password,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your password";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: _phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your Phone number";
                  }
                  else if(value.length < 11 || value.length >11){
                    return "please enter your Phone number right";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  labelText: "Phone-Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    
                  )
                ),
              ),

              SizedBox(height: 10,),


ElevatedButton(
  style: ButtonStyle(
    minimumSize: MaterialStateProperty.all(
      Size(MediaQuery.of(context).size.width, 50),
    ),
  ),
  onPressed: () {
    if (_formKey.currentState!.validate()) {
    _mybox0.put("USER_NAME", _name.text);
    _mybox0.put("USER_AGE", _age.text);
    _mybox0.put("USER_EMAIL", _email.text);
    _mybox0.put("USER_GENDER", gender);

      _mybox0.put("IS_LOGGED", true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Registration successful!"),
          backgroundColor: Color.fromARGB(255, 53, 53, 53),
          ),
         );

      usersData.add(User(
        name: _name.text,
        gender: gender,
        age: _age.text,
        email: _email.text,
        password: _password.text,
      ));

      print("User Registered: ${usersData.last.name}");
      
      _clearControllers();
      _formKey.currentState!.reset();

      Future.delayed(Duration(seconds: 2), (){
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
      }) ;
    }
  },
  child: Text("Register"),
)

            ],
          )
          ),
      ),
    );
  }
void _clearControllers() {
  _name.clear();
  _age.clear();
  _email.clear();
  _password.clear();
  _phone.clear();
}

}

