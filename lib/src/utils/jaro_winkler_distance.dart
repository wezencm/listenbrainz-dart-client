double jaroWinklerDistance(String s1, String s2) {
  if (s1.isEmpty || s2.isEmpty) {
    return 0.0; // Return 0 if either string is empty
  }

  s1 = s1.toLowerCase();
  s2 = s2.toLowerCase();

  int lengthS1 = s1.length;
  int lengthS2 = s2.length;
  int maxDistance = (lengthS1 > lengthS2 ? lengthS1 : lengthS2) ~/ 2 - 1;

  List<bool> s1Matches = List<bool>.filled(lengthS1, false);
  List<bool> s2Matches = List<bool>.filled(lengthS2, false);

  int matches = 0;
  for (int i = 0; i < lengthS1; i++) {
    int start = (i - maxDistance > 0) ? i - maxDistance : 0;
    int end = (i + maxDistance + 1 < lengthS2) ? i + maxDistance + 1 : lengthS2;

    for (int j = start; j < end; j++) {
      if (s2Matches[j] || s1[i] != s2[j]) continue;
      s1Matches[i] = true;
      s2Matches[j] = true;
      matches++;
      break;
    }
  }

  if (matches == 0) return 0.0;

  int transpositions = 0;
  int k = 0;
  for (int i = 0; i < lengthS1; i++) {
    if (!s1Matches[i]) continue;
    while (!s2Matches[k]) {
      k++;
    }
    if (s1[i] != s2[k]) transpositions++;
    k++;
  }
  transpositions ~/= 2;

  double jaroDistance = (matches / lengthS1 +
          matches / lengthS2 +
          (matches - transpositions) / matches) /
      3.0;

  int prefixLength = 0;
  for (int i = 0; i < lengthS1 && i < lengthS2 && s1[i] == s2[i]; i++) {
    prefixLength++;
  }
  prefixLength = prefixLength > 4 ? 4 : prefixLength;

  return jaroDistance + (prefixLength * 0.1 * (1 - jaroDistance));
}