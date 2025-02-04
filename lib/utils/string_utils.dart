String removeLastChars(String string, int charsCount) {
  String result = '';
  if (string.length > charsCount) {
    result = string.substring(0, string.length - charsCount);
  }
  return result;
}

bool equalsIgnoreCase(String first, String second) =>
    first.toLowerCase() == second.toLowerCase();
