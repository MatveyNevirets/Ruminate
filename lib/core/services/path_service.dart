import 'dart:io';

abstract class PathService {
  Future<Directory?> getExternalStorageDirectory();
}

class PathServiceImpl implements PathService {
  @override
  Future<Directory?> getExternalStorageDirectory() {
    return getExternalStorageDirectory();
  }
}
