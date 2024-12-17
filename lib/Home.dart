import 'package:flutter/material.dart';
import 'package:flutter_lvl5_project/data/habit_database.dart';
import 'package:flutter_lvl5_project/util/date_container.dart';
import 'package:flutter_lvl5_project/util/habit_settings_box.dart';
import 'package:flutter_lvl5_project/util/habit_tile.dart';
import 'package:flutter_lvl5_project/util/my_fab.dart';
import 'package:flutter_lvl5_project/util/new_habit_box.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  HabitDatabase db = HabitDatabase();
  final _myBox = Hive.box("Habit_Database");
  var index1Foruk;
  int _selectedIndex = 0;

  @override
  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    index1Foruk = db.habitListOfAllTime.length - 1;
    db.updateDatabase();
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void checkboxTapped(bool? newValue, int index) {
    setState(() {
      db.todaysHabitList[index][1] = newValue;
      db.habitListOfAllTime[db.habitListOfAllTime.length - 1][index][1] = newValue;
    });
    db.updateDatabase();
  }

  final _newHabitNameController = TextEditingController();

  void createHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabit(
          hintext: "Enter your new habit",
          controller: _newHabitNameController,
          onSave: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitNameController.text, false]);
    });
    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void cancelNewHabit() {
    Navigator.pop(context);
    _newHabitNameController.clear();
  }

  void saveExistingHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _newHabitNameController.text;
      db.todaysHabitList[index][1] = false;
      db.habitListOfAllTime[db.habitListOfAllTime.length - 1][index][1] = false;
    });

    _newHabitNameController.clear();
    Navigator.pop(context);
    db.updateDatabase();
  }

  void openHabitsSettings(int index) {
    _newHabitNameController.text = db.todaysHabitList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          hintext: "Enter your Habit",
          controller: _newHabitNameController,
          onSave: () {
            saveExistingHabit(index);
          },
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  Widget _buildHomePage() {
    return db.todaysHabitList.isEmpty
        ? Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              "You don't have any habits here yet, click the add button to create new one!",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Image.asset("assets/fir_p.png", width: 70,),
                Container(alignment: Alignment.center,margin: EdgeInsets.only(top: 10),decoration: BoxDecoration(color: Colors.purple[400], borderRadius: BorderRadius.circular(10)),height: 24, width: 100, child: Text(db.day_strike.toString(), style: TextStyle(fontSize: 20, color: Colors.white),)),

                SizedBox(height: 14,),
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true, 
                    itemCount: db.dates.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            index1Foruk = index;
                          });
                        },
                        child: DateContainer(date: db.dates[0].substring(6, 8), index: index,)
                      );
                    },
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,  
                  itemCount: db.habitListOfAllTime[index1Foruk].length,  
                  itemBuilder: (context, index) {
                    return HabitTile(
                      habitCompleted: db.habitListOfAllTime[index1Foruk][index][1],
                      habitName: db.habitListOfAllTime[index1Foruk][index][0],
                      onChanged: (value) => checkboxTapped(value, index),
                      settingsTapped: (context) => openHabitsSettings(index),
                      deleteTapped: (context) => deleteHabit(index),
                    );
                  },
                ),
              ],
            ),
          );
  }

  Widget _buildProfilePage() {
    return Column(
      children: [
        Container(
          child: Column(
            children: [
                Container(
                  color: Color.fromARGB(205, 255, 255, 255),
                  height: 130,
                  child: Row( // row with photo
                    children: [
                      Container(padding: EdgeInsets.all(10), decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color: Color.fromARGB(255, 241, 239, 239)),margin: EdgeInsets.all(8),child: ClipRRect(child: Icon(Icons.person_outline, size: 100, color: Color.fromARGB(255, 83, 83, 83),), borderRadius: BorderRadius.circular(300),)),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 242, 223, 255),
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Text("Female", style: TextStyle(color: Colors.purple),),
                                ),
                                SizedBox(width: 10,),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 255  , 215, 229),
                                    borderRadius: BorderRadius.circular(30)
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(Icons.star_outline, color: Colors.pink,),
                                      Text(" Started in ${db.dates[0].substring(0, 4)}", style: TextStyle(color: Colors.pink),),
                                    ],
                                  ),
                                ),
                                
                              ],
                            ),

                            Text("Ashley Robinson", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),)
                          ],
                        ),
                      )
                    ],
                  ),
                ),

            ],
          ),
        ),

        SizedBox(height: 20,),

        Text("Your Strike Score", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.purple[300]
          ),
          width: MediaQuery.of(context).size.width*0.8,
          child: Column(
            children: [
              Image.asset("assets/fir_p.png", width: 50,),
              Text("${db.day_strike}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800))
            ],
          ),
          ),

          

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Achievments", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),),
                
                Container(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    return         Container(
                      margin: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.purple[300]
              ),
              width: MediaQuery.of(context).size.width*0.6,
              child: Column(
                children: [
                  Image.asset("assets/fir_p.png", width: 50,),
                  Text("${(index+1)*25}", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),),
                  Text("Days in a row!", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),)
                ],
              ),
              );
                  },
                  ),
              ),]
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _selectedIndex == 0 ? MyFloatingActionButton(onpressed: createHabit,) : null,
      backgroundColor: Colors.purple[100],
      body: _selectedIndex == 0 ? _buildHomePage() : _buildProfilePage(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
