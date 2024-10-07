import 'package:ticket_management/models/model.dart';

class Ticket extends Model {

  static const String paramName = "ticket";

  Ticket({
    DateTime? date,
    required String name,
    int number = 1,
    DateTime? issued,
    required String code,
    bool expired = false,
  }) {
    this.date = date ?? DateTime.now();
    this.name = name;
    this.number = number;
    this.issued = issued ?? DateTime.now();
    this.code = code;
    this.expired = expired;
  }

  Ticket.fromMap(super.map) : super.fromMap();

  static const String keyDate = "date";

  static const String keyName = "name";

  static const String keyNumber = "number";

  static const String keyIssued = "issued";

  static const String keyCode = "code";

  static const String keyExpired = "expired";

  DateTime get date => getDateTime(keyDate) ?? DateTime.now();

  set date(DateTime value) => setDateTime(keyDate, value);

  String get name => getValue<String>(keyName) ?? "";

  set name(String name) => setValue<String>(keyName, name);

  int get number => getValue<int>(keyNumber) ?? 0;

  set number(number) => setValue<int>(keyNumber, number);

  DateTime get issued => getDateTime(keyIssued) ?? DateTime.now();

  set issued(value) => setDateTime(keyIssued, value);

  @override
  String get code => getValue<String>(keyCode) ?? "";

  set code(String code) => setValue<String>(keyCode, code);

  bool get expired => getValue<bool>(keyExpired) ?? true;

  set expired(bool value) => setValue<bool>(keyExpired, value);

}