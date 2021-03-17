import 'package:path/path.dart' as p;
import 'package:rename/file_repository.dart';
import 'file_repository_extension.dart';
import 'dart:io';

/// [Platform] ishlatiladigan platformalar.
enum Platform {
  android,
  ios,
  macOS,
}

/// [CBSCreate] dasturni yaratish uchun base class.
class CBSCreate {
  /// [fileRepository] fayllar bilan ishlash uchun [FileRepository] instanci.
  FileRepository fileRepository = FileRepository();

  /// [appName] dastur nomi. [args] consoledan olingan ma'lumot orqali project yaratish.
  Future create({List<String> args, String appName}) async {
    args.insert(0, 'clone');
    await Process.run('git', args,
            workingDirectory: p.current, runInShell: true)
        .then((result) {
      stdout.write(result.stdout);
      stderr.write(result.stderr);
    });

    await changeAppName(
        appName: appName, platforms: [Platform.android, Platform.ios]);
    await Process.run('flutter', ['create', '.'],
            workingDirectory: p.current + '\\' + appName, runInShell: true)
        .then((value) {
      stdout.write(value.stdout);
      stderr.write(value.stderr);
    });
  }

  /// [appName] yaratilayotgan dastur nomi. [oldAppName] eski dastur nomi.
  /// Orqali import larni o'zgartirish.
  void changeFilesImports(String appName, String oldAppName) {
    var dir = Directory(appName);
    dir
        .list(recursive: true, followLinks: false)
        .listen((FileSystemEntity entity) {
      if (entity.path.endsWith('dart') || entity.path.endsWith('.yaml')) {
        fileRepository.changeImportName(appName, entity.path, oldAppName);
      }
    });
  }

  /// [path] orqali pubspec nomini olish.
  Future<String> getPubSpecName(String path) async {
    return fileRepository.getCurrentPubSpecName(path);
  }

  /// [appName] va [platforms] orqali dastur nomini o'zgartirish.
  Future changeAppName({String appName, Iterable<Platform> platforms}) async {
    var oldName = await fileRepository.getCurrentPubSpecName(appName);
    if (platforms.isEmpty || platforms.contains(Platform.ios)) {
      await fileRepository.myChangeIosAppName(appName);
    }
    if (platforms.isEmpty || platforms.contains(Platform.macOS)) {
      await fileRepository.myChangeMacOsAppName(appName);
    }
    if (platforms.isEmpty || platforms.contains(Platform.android)) {
      await fileRepository.myChangeAndroidAppName(appName);
    }
    changeFilesImports(appName, oldName);
  }
}
