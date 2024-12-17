String todaysDateFormatted() {
  // today
  var dateTimeObject = DateTime.now();

  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }

  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = "0" + day;
  }

  // hour in the format hh
  String hour = dateTimeObject.hour.toString();
  if (hour.length == 1) {
    hour = "0" + hour;
  }

  // minute in the format mm
  String minute = dateTimeObject.minute.toString();
  if (minute.length == 1) {
    minute = "0" + minute;
  }

  // second in the format ss
  String second = dateTimeObject.second.toString();
  if (second.length == 1) {
    second = "0" + second;
  }

  // final format
  String yyyymmddhhmmss = year + month + day + hour + minute + second;

  return yyyymmddhhmmss;
}

DateTime createDateTimeObjects(String yyyymmddhhmmss) {
  int yyyy = int.parse(yyyymmddhhmmss.substring(0, 4));
  int mm = int.parse(yyyymmddhhmmss.substring(4, 6));
  int dd = int.parse(yyyymmddhhmmss.substring(6, 8));
  int hh = int.parse(yyyymmddhhmmss.substring(8, 10));
  int min = int.parse(yyyymmddhhmmss.substring(10, 12));
  int ss = int.parse(yyyymmddhhmmss.substring(12, 14));

  DateTime dateTimeObject = DateTime(yyyy, mm, dd, hh, min, ss);
  return dateTimeObject;
}

String convertDateTimeObjectToString(DateTime dateTimeObject) {
  // year in the format yyyy
  String year = dateTimeObject.year.toString();

  // month in the format mm
  String month = dateTimeObject.month.toString();
  if (month.length == 1) {
    month = "0" + month;
  }

  // day in the format dd
  String day = dateTimeObject.day.toString();
  if (day.length == 1) {
    day = "0" + day;
  }

  // hour in the format hh
  String hour = dateTimeObject.hour.toString();
  if (hour.length == 1) {
    hour = "0" + hour;
  }

  // minute in the format mm
  String minute = dateTimeObject.minute.toString();
  if (minute.length == 1) {
    minute = "0" + minute;
  }

  // second in the format ss
  String second = dateTimeObject.second.toString();
  if (second.length == 1) {
    second = "0" + second;
  }

  String yyyymmddhhmmss = year + month + day + hour + minute + second;

  return yyyymmddhhmmss;
}
