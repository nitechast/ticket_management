import 'package:ticket_management/models/schedule.dart';
import 'package:ticket_management/models/ticket.dart';
import 'package:ticket_management/models/user.dart';

class Model {

  static String getParam<T>() {
    if (T == Model) {
      return "models";
    } else if (T == Ticket) {
      return "tickets";
    } else if (T == Schedule) {
      return "schedules";
    } else if (T == User) {
      return "users";
    }
    throw UnimplementedError();
  }

  Model();

  Model.fromMap(Map<String, dynamic> map) {
    _map = map;
  }

  Map<String, dynamic> get map => _map;

  Map<String, dynamic> _map = {};

  bool get isValid => map.isNotEmpty;

  String get code => throw UnimplementedError();

  T? getValue<T>(String key) {
    if (!map.containsKey(key)) {
      return null;
    }
    return map[key]!;
  }

  DateTime? getDateTime(String key) {
    final raw = getValue<String>(key);
    if (raw == null) {
      return null;
    }
    return DateTime.parse(raw).toLocal();
  }

  void setValue<T>(String key, T value) {
    map[key] = value;
  }

  void setDateTime(String key, DateTime value) {
    setValue<String>(key, value.toUtc().toIso8601String());
  }

}