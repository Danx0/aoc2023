import 'dart:convert';
import 'dart:io';

const String version = '0.0.1';

Future<void> main(List<String> arguments) async {
  final path = "input";
  final lines =
      utf8.decoder.bind(File(path).openRead()).transform(const LineSplitter());

  var lineNumnber = 0;
  var sum = 0;
  try {
    await for (final line in lines) {
      sum += findCalibrationValue(line);
      lineNumnber++;
    }
  } catch (_) {
    await _handleError(path);
  }

  stdout.writeln("Number of lines: $lineNumnber");
  stdout.writeln("Sum of calibration values: $sum");
}

int findCalibrationValue(String line) {
  var sanitizedFirst = sanitizeFirst(line);
  var sanitizedLast = sanitizeLast(line);
  return findFirstValue(sanitizedFirst) * 10 + findLastValue(sanitizedLast);

  // for part 1:
  //return findFirstValue(line) * 10 + findLastValue(line);
}

int findFirstValue(String line) {
  for (int i = 0; i < line.length; i++) {
    var possibleInt = int.tryParse(line[i]);
    if (possibleInt != null) {
      return possibleInt;
    }
  }

  throw Exception();
}

int findLastValue(String line) {
  for (int i = line.length; i > 0; i--) {
    var possibleInt = int.tryParse(line[i - 1]);
    if (possibleInt != null) {
      return possibleInt;
    }
  }

  throw Exception();
}

String sanitizeFirst(String line) {
  line = line.replaceFirst("one", "one1one");
  line = line.replaceFirst("two", "two2two");
  line = line.replaceFirst("three", "three3three");
  line = line.replaceFirst("four", "four4four");
  line = line.replaceFirst("five", "five5five");
  line = line.replaceFirst("six", "six6six");
  line = line.replaceFirst("seven", "seven7seven");
  line = line.replaceFirst("eight", "eight8eight");
  line = line.replaceFirst("nine", "nine9nine");
  return line;
}

String sanitizeLast(String line) {
  line = line.replaceLast("one", "one1one");
  line = line.replaceLast("two", "two2two");
  line = line.replaceLast("three", "three3three");
  line = line.replaceLast("four", "four4four");
  line = line.replaceLast("five", "five5five");
  line = line.replaceLast("six", "six6six");
  line = line.replaceLast("seven", "seven7seven");
  line = line.replaceLast("eight", "eight8eight");
  line = line.replaceLast("nine", "nine9nine");
  return line;
}

extension MyString on String {
  String replaceLast(Pattern from, String to) {
    var position = lastIndexOf(from).clamp(0, length);
    return replaceFirst(from, to, position);
  }
}

Future<void> _handleError(String path) async {
  if (await FileSystemEntity.isDirectory(path)) {
    stderr.writeln('error: $path is a directory');
  } else {
    exitCode = 2;
  }
}
