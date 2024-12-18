import 'package:hive/hive.dart';


@HiveType(typeId: 1)
class User extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String gender;

  @HiveField(2)
  String age;

  @HiveField(3)
  String email;

  @HiveField(4)
  String password;

  User({
    required this.name,
    required this.gender,
    required this.age,
    required this.email,
    required this.password,
  });
}

List<User> usersData = [
  User(
    name: "Dimash Balabek",
    gender: "Male",
    age: "17",
    email: "dimash@example.com",
    password: "123",
  ),
];
