import 'package:intl/intl.dart';

//HomrPage
String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedTime =
      "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
  return formattedTime;
}

//Forecast page (wind section)
String formatTime(String inputDate) {
  final dateTime = DateTime.parse(inputDate);
  final formattedTime = DateFormat('h a').format(dateTime);
  return formattedTime;
}

//Example Fri, 20
String formatDateTime2(String inputDate) {
  final dateTime = DateTime.parse(inputDate);
  final formattedDate = DateFormat('E, d').format(dateTime);
  return formattedDate;
}

String formatDateTime3(DateTime dateTime) {
  String formattedDate = DateFormat('E, d').format(dateTime); // Format the date
  String formattedTime = DateFormat('h:mm a')
      .format(dateTime); // Format the time without seconds and AM/PM

  return '$formattedDate - $formattedTime';
}

String formatDateTime4(DateTime dateTime) {
  String formattedDate = DateFormat('d').format(dateTime); // Format the date
  // String formattedTime = DateFormat('h:mm a')
  //     .format(dateTime); // Format the time without seconds and AM/PM

  return formattedDate;
}
