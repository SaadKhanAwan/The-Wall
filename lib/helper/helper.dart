import 'package:cloud_firestore/cloud_firestore.dart';

class FormatedDate {
  static String formatedDate(Timestamp time) {
    DateTime date = time.toDate();
    String year = date.year.toString();
    String month = date.month.toString();
    String day = date.day.toString();

    String formated = "$day/$month/$year";
    return formated;
  }

  static String formatedTime(Timestamp time) {
    DateTime times = time.toDate();
    String seconds = times.second.toString();
    String hours = times.hour.toString();
    String minintes = times.minute.toString();

    String formated = "$hours:$minintes:$seconds";
    return formated;
  }
}
