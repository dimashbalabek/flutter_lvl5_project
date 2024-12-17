
class User {
  String name = "";
  String gender = "";
  String email = "";
  String password = "";
  String age = "";

  User({
    required this.name,
    required this.gender,
    required this.age,
    required this.email,
    required this.password
  }); 
}

List<User>  usersData = [
  User(
    name: "Dimash Balabek",
    gender: "Male",
    age: "",
    email: "@",
    password: "123",
    )
];