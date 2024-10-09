import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ticket_management/models/model.dart';

class Schedule extends Model {

  static const String paramName = "schedules";

  static const String formatDateTime = "yyyy-MM-dd HH:mm";

  static const String keyDateTime = "datetime";

  static const String keySeats = "seats";

  static const int seatsMin = 1, seatsMax = 10;

  static String getCode(DateTime datetime) {
    return DateFormat(formatDateTime).format(datetime);
  }

  Schedule([
    DateTime? datetime,
    int seats = seatsMin,
  ]) : super() {
    this.datetime = datetime ?? DateTime.now();
    this.seats = seats;
  }

  Schedule.fromMap(super.map) : super.fromMap();

  @override
  String get code => getCode(datetime);

  DateTime get datetime => getDateTime(keyDateTime) ?? DateTime.now();

  set datetime(DateTime value) => setDateTime(keyDateTime, value);

  void changeDate(DateTime date) => setDate(keyDateTime, date);

  void changeTime(TimeOfDay tod) => setTime(keyDateTime, tod);

  int get seats => getValue<int>(keySeats) ?? seatsMin;

  set seats(value) => setValue<int>(keySeats, value);

}