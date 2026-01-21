List<String> compareJsonStructure(
  dynamic expected,
  dynamic actual, {
  String path = 'root',
  Set<String> optionalPaths = const {},
}) {
  final differences = <String>[];

  if (expected == null || actual == null) {
    if (expected != actual && !_matchesOptionalPath(path, optionalPaths)) {
      differences.add('$path: one is null, the other is not');
    }
    return differences;
  }

  if (expected is Map && actual is Map) {
    final expectedKeys = expected.keys.toSet();
    final actualKeys = actual.keys.toSet();

    final missingInActual = expectedKeys.difference(actualKeys);
    final missingInExpected = actualKeys.difference(expectedKeys);

    for (var key in missingInActual) {
      final fullPath = '$path.$key';
      if (!_matchesOptionalPath(fullPath, optionalPaths)) {
        differences.add('$path: is missing a key {$key}');
      }
    }
    for (var key in missingInExpected) {
      final fullPath = '$path.$key';
      if (!_matchesOptionalPath(fullPath, optionalPaths)) {
        differences.add('$path: has an extra key {$key}');
      }
    }

    for (var key in expectedKeys.intersection(actualKeys)) {
      differences.addAll(compareJsonStructure(
        expected[key],
        actual[key],
        path: '$path.$key',
        optionalPaths: optionalPaths,
      ));
    }
    return differences;
  }

  if (expected is List && actual is List) {
    if (expected.length != actual.length &&
        !_matchesOptionalPath(path, optionalPaths)) {
      differences.add('$path: length mismatch expected: [${expected.length}] got: [${actual.length}]');
    }
    final minLength = expected.length < actual.length ? expected.length : actual.length;
    for (var i = 0; i < minLength; i++) {
      differences.addAll(compareJsonStructure(
        expected[i],
        actual[i],
        path: '$path[$i]',
        optionalPaths: optionalPaths,
      ));
    }
    return differences;
  }

  if (expected.runtimeType != actual.runtimeType &&
      !_matchesOptionalPath(path, optionalPaths)) {
    differences.add('$path: type mismatch, expected: [${expected.runtimeType}] got: [${actual.runtimeType}]');
  }

  return differences;
}

bool _matchesOptionalPath(String path, Set<String> optionalPaths) {
  for (var opt in optionalPaths) {
    // Escape regex special chars except '*'
    final regexPattern = '^' +
        RegExp.escape(opt).replaceAll(r'\*', r'.*') +
        r'$';
    final regex = RegExp(regexPattern);
    if (regex.hasMatch(path)) return true;
  }
  return false;
}
