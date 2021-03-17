import 'package:args/args.dart';
import 'package:cbs_create/cbs_create.dart';

const android = 'android';
const macOS = 'macOS';
const ios = 'ios';

const target = 'target';
const appname = 'appname';
const url = 'url';
const bundleId = 'bundleId';
const launcherIcon = 'launcherIcon';
const help = 'help';

const String templateURL = 'https://github.com/webdastur/cbs_architecture';

final argParser = ArgParser()
  ..addOption(appname, abbr: 'a', help: 'Dastur nomini o\'rnatadi.')
  ..addFlag(help, abbr: 'h', help: 'Yordam.', negatable: false);

void main(List<String> arguments) async {
  try {
    final results = argParser.parse(arguments);
    if (results[help] || results.arguments.isEmpty) {
      print(argParser.usage);
      print('Ushbu extension CBS Architecture orqali proyekt tuzish uchun yaratildi.\nMuallif: Abdulaminkhon Khaydarov');
      return;
    }

    if (results[appname] != null) {
      var sourceCreator = CBSCreate();
      sourceCreator.create(
        args: [
          templateURL, //url
          results[appname], //'my_donation'
        ],
        appName: results[appname],
      );
    }
  } on FormatException catch (e) {
    print(e.message);
    print('');
    print(argParser.usage);
  }
}
