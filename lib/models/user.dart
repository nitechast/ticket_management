import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:ticket_management/models/model.dart';

class User extends Model {

  static const String paramName = "users";

  static const int levelAdmin = 0;

  static const int levelEditor = 5;

  static const int levelUser = 8;

  static const int levelDefault = 9;

  static const String nameAnonymous = "anonymous";

  static const String keyLevel = "level";

  static const String keyName = "name";

  static const String keyImageUrl = "url";

  User() : super();

  User.fromMap(super.map) : super.fromMap();

  User.fromFirebase(auth.User user) {
    map[Model.keyUid] = user.uid;
    map[keyName] = user.displayName;
    map[keyImageUrl] = user.photoURL;
  }

  User.anonymous() {
    map[Model.keyUid] = nameAnonymous;
    map[keyName] = nameAnonymous;
  }

  @override
  String get code => uid;

  int get level => getValue<int>(keyLevel) ?? levelDefault;

  String get name => getValue<String>(keyName) ?? "";

  String? get imageUrl => getValue<String>(keyImageUrl);

  bool get isUser => level <= levelUser;

  bool get isEditor => level <= levelEditor;

  bool get isAdmin => level <= levelAdmin;

}