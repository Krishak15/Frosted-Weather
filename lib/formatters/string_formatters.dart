String capitalize(String word) {
    return word[0].toUpperCase() + word.substring(1);
  }

//remove celcius

String formatCelsius(String input) {
  return input.replaceAll(RegExp(r' Celsius$'), '');
}
