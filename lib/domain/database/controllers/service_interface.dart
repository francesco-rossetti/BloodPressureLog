abstract class ServiceInterface<T> {
  // ignore: missing_return, body_might_complete_normally_nullable
  Future<List<T>?> readAll() async {}
  // ignore: missing_return, body_might_complete_normally_nullable
  Future<T?> readByID(int id) async {}
  // ignore: missing_return, body_might_complete_normally_nullable
  Future<bool?> insert(T data) async {}
  // ignore: missing_return, body_might_complete_normally_nullable
  Future<bool?> update(T data) async {}
  // ignore: missing_return, body_might_complete_normally_nullable
  Future<bool?> delete(T data) async {}
}
