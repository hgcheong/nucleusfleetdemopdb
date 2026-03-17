import 'dart:ui';

extension ColorExtension on Color {
  /// Convert the color to a darken color based on the [percent]
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      a.round(),
      (r * value).round(),
      (g * value).round(),
      (b * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      a.round(),
      (r + ((255 - r) * value)).round(),
      (g + ((255 - g) * value)).round(),
      (b + ((255 - b) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (r + other.r) ~/ 2;
    final green = (g + other.g) ~/ 2;
    final blue = (b + other.b) ~/ 2;
    final alpha = (a + other.a) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }
}
