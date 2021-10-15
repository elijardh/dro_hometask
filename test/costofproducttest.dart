import 'dart:ffi';
import 'package:dro_hometask/presentation/reuseables/cartwidget.dart';

import 'package:flutter_test/flutter_test.dart';

void main(List<String> args) {
  test("Result should be the product of the two inputs", () {
    int firstValue = 10;
    int secondValue = 20;
    int product = totalCostOfProduct(firstValue, secondValue);
    expect(product, 200);
  });
}
