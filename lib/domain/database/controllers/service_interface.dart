abstract class ServiceInterface<T> {
  // ignore: missing_return
  Future<List<T>?> readAll() async {}
  // ignore: missing_return
  Future<T?> readByID(int id) async {}
  // ignore: missing_return
  Future<bool?> insert(T data) async {}
  // ignore: missing_return
  Future<bool?> update(T data) async {}
  // ignore: missing_return
  Future<bool?> delete(T data) async {}
}
