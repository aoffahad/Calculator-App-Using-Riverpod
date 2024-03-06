import 'package:calculator_with_riverpod/widget/utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:math_expressions/math_expressions.dart';

import 'model/calculator.dart';

final calculatorProvider = StateNotifierProvider<CalculatorNotifier, dynamic>(
    (ref) => CalculatorNotifier());

class CalculatorNotifier extends StateNotifier<Calculator> {
  CalculatorNotifier()
      : super(Calculator(shouldAppend: true, equation: '0', result: '0'));

  void delete() {
    final equation = state.equation;
    if (equation.isNotEmpty) {
      final newEquation = equation.substring(0, equation.length - 1);

      if (newEquation.isEmpty) {
        reset();
      } else {
        state = state.copyWith(equation: newEquation);
        calculate();
      }
    }
  }

  void append(String buttonText) {
    final equation = () {
      // print("Append Method Called");
      if (Utils.isOperator(buttonText) &&
          Utils.isOperatorAtEnd(state.equation)) {
        final newEquation =
            state.equation.substring(0, state.equation.length - 1);

        return newEquation + buttonText;
      } else {
        return state.equation == '0' ? buttonText : state.equation + buttonText;
      }
    }();
    state = state.copyWith(equation: equation);
  }

  void equals() {
    calculate();
  }

  void calculate() {
    final expression = state.equation.replaceAll('x', '*').replaceAll('÷', '/');

    try {
      final exp = Parser().parse(expression);
      final model = ContextModel();
      final result = '${exp.evaluate(EvaluationType.REAL, model)}';

      state = state.copyWith(result: result);
    } catch (e) {}
  }

  void reset() {
    const equation = '0';
    const result = '0';

    state = state.copyWith(equation: equation, result: result);
  }
}
