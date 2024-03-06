import 'package:calculator_with_riverpod/riverpod.dart';
import 'package:calculator_with_riverpod/widget/button_widget.dart';
import 'package:calculator_with_riverpod/widget/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final calculatorResult = ref.watch(calculatorProvider.notifier).state;
    return Scaffold(
      backgroundColor: MyColors.background1,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(left: 8),
          child: const Text(
            "Calculator",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: buildResult(calculatorResult)),
            Expanded(flex: 2, child: buildButtons())
          ],
        ),
      ),
    );
  }

  Widget buildResult(calculatorResult) => Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          return Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  calculatorResult.equation,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 36, height: 1),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  calculatorResult.result,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: Colors.grey, fontSize: 18, height: 1),
                ),
              ],
            ),
          );
        },
      );

  Widget buildButtons() => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: MyColors.background2,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20))),
        child: Column(
          children: <Widget>[
            buildButtonRow("AC", "<", "", "÷"),
            buildButtonRow('7', '8', '9', 'x'),
            buildButtonRow('4', '5', '6', '-'),
            buildButtonRow('1', '2', '3', '+'),
            buildButtonRow('0', '00', '.', '='),
          ],
        ),
      );

  buildButtonRow(String first, String second, String third, String fourth) {
    final row = [first, second, third, fourth];

    return Expanded(
      child: Row(
          children: row
              .map((text) => Consumer(
                    builder:
                        (BuildContext context, WidgetRef ref, Widget? child) {
                      return ButtonWidget(
                        text: text,
                        onClicked: () => onClickedButton(text, ref),
                        onClickedLong: () => onLongClickButton(text, ref),
                      );
                    },
                  ))
              .toList()),
    );
  }

  void onClickedButton(String buttonText, WidgetRef ref) {
    final calculator = ref.read(calculatorProvider.notifier);
    // calculator.append(buttonText);
    switch (buttonText) {
      case 'AC':
        calculator.reset();
        break;
      case '=':
        calculator.equals();
        break;
      case '<':
        calculator.delete();
        break;
      default:
        calculator.append(buttonText);
        break;
    }
    setState(() {});
  }

  onLongClickButton(String text, WidgetRef ref) {
    final calculator = ref.read(calculatorProvider.notifier);

    if (text == '<') {
      calculator.reset();
    }
    setState(() {});
  }
}
