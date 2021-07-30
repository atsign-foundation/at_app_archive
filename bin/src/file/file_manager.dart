// @dart = 2.8

import 'dart:io';
import 'package:flutter_tools/src/globals.dart' as globals;

class FileManager {
  File file;

  static File fileFromPath(String filePath) =>
      File(globals.fs.path.relative(filePath, from: Directory.current.path));

  FileManager(Directory projectDir, String filename)
      : file = fileFromPath('${projectDir.absolute.path}/$filename');

  bool get existsSync => file.existsSync();

  Future<bool> create() async {
    if (!existsSync) {
      try {
        file = await file.create(recursive: true);
      } catch (error) {
        print(error.toString());
        return false;
      }
    }
    return true;
  }

  Future<void> write(List<String> lines) async {
    var sink = file.openWrite(mode: FileMode.writeOnly);
    sink.writeAll(lines, '\n');
    await sink.flush();
    await sink.close();
  }
}
