import 'package:flutter_lvl5_project/datetime/date_time.dart';
import 'package:hive/hive.dart';

final _myBox = Hive.box('Habit_Database');


class HabitDatabase {
  var lastd = DateTime.now();
  int day_strike = 0;
  List todaysHabitList = [];
  List habitListOfAllTime = [];
  List dates = [];
  Map<DateTime, int> heatMapDataSet = {};

  

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ["Run", false],
      ["Read", false],
    ];

    dates = [todaysDateFormatted()];

    habitListOfAllTime = [
      [ ["Run", false], ["Read", false], ],
    ];


    _myBox.put("START_DATE", todaysDateFormatted());
    _myBox.put("DAY_STRIKE", 0);
    _myBox.put("DATES", [todaysDateFormatted()]);
    _myBox.put("DATES_DATA", habitListOfAllTime);

  }

  // load data if it already exists
  void loadData() {
    // if it's a new day, get habit list from database
    if (_myBox.get(todaysDateFormatted()) == null) {

      // 
      habitListOfAllTime = _myBox.get("DATES_DATA");

      // загружаем данные из бокса с названием DATES где даты сохраняется ввиде String
      dates = _myBox.get("DATES");
      // добавляем новый день 
      dates.add(todaysDateFormatted());

      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");
      // обнавляем данные даты
      _myBox.put("DATES", dates);


      // загружаем данные из даты DAY_STRIKE
      day_strike = _myBox.get("DAY_STRIKE");

      // if every habit is complete, add a new strike day 
      int count = 0; //the checker if every habit is completed
      for (var i = 0; i < todaysHabitList.length; i++) {
        if (todaysHabitList[i][1] == true) {
          count+=1;
        }
      }

              if (count == todaysHabitList.length) {
          day_strike+=1;
        }else if(count != todaysHabitList.length){
        }

        _myBox.put("DAY_STRIKE", day_strike);


      // set all habit completed to false since it's a new day
      for (var i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
      
      habitListOfAllTime.add(todaysHabitList);
      _myBox.put("DATES_DATA", habitListOfAllTime);

    } else {
      // if it's not, load today's list
      todaysHabitList = _myBox.get(todaysDateFormatted());
      dates = _myBox.get("DATES");
    }
  }

  // update database
  void updateDatabase() {
    // update today's entry
    _myBox.put(todaysDateFormatted(), todaysHabitList);
    
    // update universal habit list in case it changed (new habit, edit habit, delete habit, etc.)
    _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

    _myBox.put("DATES_DATA", habitListOfAllTime);

    // calculate habit complete percentages for each day
    calculateHabitPercentages();

    // load heat map
    // loadHeatMap();
  }

  void calculateHabitPercentages() {
    int countCompleted = 0;

    for (var i = 0; i < todaysHabitList.length; i++) {
      if (todaysHabitList[i][1] == true) {
        countCompleted++;
      }
    }

    String percent = todaysHabitList.isEmpty
        ? "0.0"
        : (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    // key: "PERCENTAGE_SUMMARY_yyyymmdd"
    // value string of 1dp number between 0-1 inclusive
    _myBox.put("PERCENTAGE_SUMMARY_yyyymmdd${todaysDateFormatted()}", percent);
  }

  // void loadHeatMap() {
  //   DateTime startDate = createDateTimeObjects(_myBox.get("START_DATE"));

  //   // count the number of days to load 
  //   int daysInBetween = DateTime.now().difference(startDate).inDays;

  //   // go from start date to today and add each percentage to the dataset
  //   // "PERCENTAGE_SUMMARY_yyyymmdd" will be the key in the database
  //   for (var i = 0; i < daysInBetween; i++) {
  //     String yyyymmdd = ConvertDateTimeObjectToString(
  //       startDate.add(Duration(days: i)),
  //     );

  //     double strengthAsPercent = double.parse(
  //       _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
  //     );

  //     // split the datetime up like below so it does not worry about hours/mins/secs, etc.

  //     // year
  //     int year = startDate.add(Duration(days: i)).year;

  //     // month
  //     int month = startDate.add(Duration(days: i)).month;

  //     // day
  //     int day = startDate.add(Duration(days: i)).day;

  //     // If the entry already exists, we can update the value, else we add a new entry
  //     if (!heatMapDataSet.containsKey(DateTime(year, month, day))) {
  //       heatMapDataSet[DateTime(year, month, day)] = (10 * strengthAsPercent).toInt();
  //     } else {
  //       // If exists, we update the value
  //       heatMapDataSet[DateTime(year, month, day)] = 
  //           (heatMapDataSet[DateTime(year, month, day)] ?? 0) + (10 * strengthAsPercent).toInt();
  //     }
  //   }
  // }
}
