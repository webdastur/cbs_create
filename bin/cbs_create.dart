import 'package:args/args.dart';
import 'package:cbs_create/cbs_create.dart';

/// [android] platforma nomi
const android = 'android';

/// [macOS] platforma nomi
const macOS = 'macOS';

/// [ios] platforma nomi
const ios = 'ios';

/// [target] qaratilgan manzil.
const target = 'target';

/// [appname] dastur nomi.
const appname = 'appname';

/// [url] manzil.
const url = 'url';

/// [bundleId] bundleId nomi.
const bundleId = 'bundleId';

/// [launcherIcon] nomi.
const launcherIcon = 'launcherIcon';

/// [help] yordam.
const help = 'help';

/// [template] template nomi
const String template = 'template';

/// [templateURL] yaratiladigan template manzili.
const String templateURL = 'https://github.com/webdastur/cbs_architecture';

const String getTemplateURL = 'https://github.com/webdastur/get_architecture';

/// [argParser] console ma'lumotlarini o'qish uchun.
final argParser = ArgParser()
  ..addOption(appname, abbr: 'a', help: 'Dastur nomini o\'rnatadi.')
  ..addOption(template, abbr: 't', help: 'Template nomi bloc yoki get')
  ..addFlag(help, abbr: 'h', help: 'Yordam.', negatable: false);

/// Asosiy [main] method.
void main(List<String> arguments) async {
  try {
    final results = argParser.parse(arguments);
    if (results[help] || results.arguments.isEmpty) {
      print(argParser.usage);
      print('Ushbu extension CBS Architecture orqali proyekt tuzish uchun yaratildi.\nMuallif: Abdulaminkhon Khaydarov');
      return;
    }

    if (results[template] == '' || results[template] == null) {
      print('Iltimos template nomini kiriting!');
      return;
    }

    if (results[appname] != null) {
      var sourceCreator = CBSCreate();
      await sourceCreator.create(
        args: [
          results[template] == 'bloc' ? templateURL : getTemplateURL,
          results[appname],
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
