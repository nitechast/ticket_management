import 'package:easy_localization/easy_localization.dart';
import 'package:ticket_management/models/model.dart';

class Schedule extends Model {

  static const String formatDateTime = "yyyy-MM-dd HH:mm";

  static const String keyDateTime = "datetime";

  static const String keySeats = "seats";

  static String getCode(DateTime datetime) {
    return DateFormat(formatDateTime).format(datetime);
  }

  Schedule.fromMap(super.map) : super.fromMap();

  String get code => getCode(datetime);

  DateTime get datetime => getDateTime(keyDateTime) ?? DateTime.now();

  set datetime(DateTime value) => setDateTime(keyDateTime, value);

  int get seats => getValue<int>(keySeats) ?? 0;

  set seats(value) => setValue<int>(keySeats, value);

}