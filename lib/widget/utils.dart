class Utils {
  static bool isOperator(String buttonText, {bool hasEquals = false}) {
    final operators = ['+', '-', '÷', 'x', '.']..addAll(hasEquals ? ['='] : []);

    return operators.contains(buttonText);
  }

  static bool isOperatorAtEnd(String equation) {
    if (equation.isNotEmpty) {
      return Utils.isOperator(equation.substring(equation.length - 1));
    } else {
      return false;
    }
  }
}
