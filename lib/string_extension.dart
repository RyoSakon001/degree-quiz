extension StringExtension on String {
  String get cutZero {
    String text = this;
    while (text.last == '0') {
      text = text.cutLast;
    }
    if (text.last == '.') {
      text = text.cutLast;
    }
    return text;
  }

  String get last {
    String text = this;
    return text.substring(text.length - 1, text.length);
  }

  String get lastTwo {
    String text = this;
    return text.substring(text.length - 2, text.length);
  }

  String get cutLast {
    String text = this;
    return text.substring(0, text.length - 1);
  }

  String get avogadroDegree {
    String text = this;
    if (!(text.contains('e+') || text.contains('e-'))) return text;

    int power = int.parse(text.lastTwo) + 23;

    text = text.cutLast + power.toString();

    return (text.contains('e+'))
        ? text.replaceFirst('e+', ' × 10^')
        : text.replaceFirst('e-', ' × 10^');
  }
}
