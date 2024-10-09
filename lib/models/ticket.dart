import 'package:ticket_management/models/model.dart';
import 'package:ticket_management/models/schedule.dart';

class Ticket extends Model {

  static const String paramName = "ticket";

  Ticket({
    required Schedule schedule,
    required String name,
    int seats = Schedule.seatsMin,
    DateTime? issued,
    required String code,
    bool expired = false,
  }) : super() {
    scheduleUid = schedule.uid;
    this.name = name;
    this.seats = seats;
    this.issued = issued ?? DateTime.now();
    this.code = code;
    this.expired = expired;
  }

  Ticket.fromMap(super.map) : super.fromMap();

  static const String keySchedule = "schedule";

  static const String keyName = "name";

  static const String keySeats = "seats";

  static const String keyIssued = "issued";

  static const String keyCode = "code";

  static const String keyExpired = "expired";

  String get scheduleUid => getValue<String>(keySchedule) ?? "";

  set scheduleUid(String uid) => setValue<String>(keySchedule, uid);

  String get name => getValue<String>(keyName) ?? "";

  set name(String name) => setValue<String>(keyName, name);

  int get seats => getValue<int>(keySeats) ?? Schedule.seatsMin;

  set seats(number) => setValue<int>(keySeats, number);

  DateTime get issued => getDateTime(keyIssued) ?? DateTime.now();

  set issued(value) => setDateTime(keyIssued, value);

  @override
  String get code => getValue<String>(keyCode) ?? "";

  set code(String code) => setValue<String>(keyCode, code);

  bool get expired => getValue<bool>(keyExpired) ?? true;

  set expired(bool value) => setValue<bool>(keyExpired, value);

}