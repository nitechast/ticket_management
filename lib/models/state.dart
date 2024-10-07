import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticket_management/firebase.dart';
import 'package:ticket_management/models/model.dart';

class ModelsState<T extends Model> extends StateNotifier<List<T>> {

  ModelsState(this.ref) : super([]);

  final Ref ref;

  /// Clear state
  void clear() => state = [];

  Future<void> set(String section, String namespace, T data) async {
    final client = FirebaseHelper();
    await client.set<T>(
      section: section,
      namespace: namespace,
      data: data,
    );
    get(section, namespace);
  }

  /// Request [T] items fit to [condition] and filter by [options]
  ///
  /// This method overrides [state]
  Future<void> get(String section, String namespace) async {
    final client = FirebaseHelper();
    final List<T> response = await client.get<T>(
      section: section,
      namespace: namespace,
    );
    if (response.isEmpty) {
      return;
    }
    state = response;
  }
}

class ObjectState<T extends Model> extends StateNotifier<T> {

  ObjectState(this.ref, this.base) : super(base);

  final Ref ref;

  final T base;

  /// Clear state
  void clear() => state = base;

  void set(T object) async {
    state = object;
  }
}