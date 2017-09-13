import 'dart:math';

//main(List<String> arguments) async {
main(List<String> arguments) {
  int minDigitsForComparison = 2;
  int maxDigitsForComparison = 7;
  int minBase = 10;
  int maxBase = 10;
  print("Starting at " + (new DateTime.now()).toString());
  Stopwatch stopWatch = new Stopwatch();
  for (int base = minBase; base <= maxBase; base++) {
    for (int nDigitsForComparison = minDigitsForComparison; nDigitsForComparison <= maxDigitsForComparison; nDigitsForComparison++) {
      stopWatch.start();
      List<int> digits = new List<int>.filled(nDigitsForComparison, 0);
//      await generateDigitsRecursively(digits, base, nDigitsForComparison, 0);
      generateDigitsRecursively(digits, base, nDigitsForComparison, 0);
      stopWatch.stop();
      print("\tProcessed ${nDigitsForComparison}-digit numbers in base $base in ${stopWatch.elapsed.inMilliseconds} milliseconds.");
      stopWatch.reset();
    }
  }
  print("Finished at " + (new DateTime.now()).toString());
}

//generateDigitsRecursively(List<int> digits, int base, int nDigitsForComparison, int digitPosition) async {
generateDigitsRecursively(List<int> digits, int base, int nDigitsForComparison, int digitPosition) {
  //print("In generateDigitsRecursively");
  for (int digitValue = 0; digitValue < base; digitValue++) {
    digits[digitPosition] = digitValue;
    if (digitPosition == 0 && digits[0] == 0) {
      continue; // skip all numbers where leftmost digit is 0
    }
    if (digitPosition < nDigitsForComparison - 1) {
      generateDigitsRecursively(digits, base, nDigitsForComparison, digitPosition + 1);
    }
    else {
//      List<int> forwardNumberList = digits;
//      List<int> reversedNumberList = new List<int>.from(digits.reversed);
//      if (reversedNumberList[0] == 0) {
//        continue; // skip numbers not right size
//      }
//      //
//      // Convert digit position values to a number
//      //
//      int forwardNumber = 0;
//      int reversedNumber = 0;
//      for (int digitPositionCtr = 0; digitPositionCtr < nDigitsForComparison; digitPositionCtr++) {
//        forwardNumber = forwardNumber + forwardNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
//        reversedNumber = reversedNumber + reversedNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
//      }
//      //
//      // if the division would be less than or equal to 1, then skip.
//      //
//      if (forwardNumber >= reversedNumber) {
//        continue;
//      }
//      int mDivNRemainder = reversedNumber % forwardNumber;
//      if (mDivNRemainder == 0) {
//        int wholeNumberMultiple = reversedNumber ~/ forwardNumber;
//        print("Base $base, digits:$nDigitsForComparison, n: ${forwardNumber.toRadixString(base)}, m: ${reversedNumber.toRadixString(base)},  ${wholeNumberMultiple.toRadixString(base)} * ${forwardNumber.toRadixString(base)} == ${reversedNumber.toRadixString(base)}");
//        continue;
//      }
        List<String> triple = checkDigits(digits, base, nDigitsForComparison);
        if (triple != null) {
          print("Base $base, digits:$nDigitsForComparison, n: ${triple[0]}, m: ${triple[0]},  ${triple[0]} * ${triple[0]} == ${triple[1]}");
        }
    }
  }
  //print("Leaving generateDigitsRecursively");
}
// return a solution of [n, m, w] if digits has reversedNumber % forwardNumber == 0
List<String> checkDigits(List<int> digits, int base, int nDigitsForComparison) {
  List<int> forwardNumberList = digits;
  List<int> reversedNumberList = new List<int>.from(digits.reversed);
  if (reversedNumberList[0] == 0) {
    return null;
  }
  //
  // Convert digit position values to a number
  //
  int forwardNumber = 0;
  int reversedNumber = 0;
  for (int digitPositionCtr = 0; digitPositionCtr < nDigitsForComparison; digitPositionCtr++) {
    forwardNumber = forwardNumber + forwardNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
    reversedNumber = reversedNumber + reversedNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
  }
  //
  // if the division would be less than or equal to 1, then skip.
  //
  if (forwardNumber >= reversedNumber) {
    return null;
  }
  int mDivNRemainder = reversedNumber % forwardNumber;
  if (mDivNRemainder == 0) {
    int wholeNumberMultiple = reversedNumber ~/ forwardNumber;
    //print("Base $base, digits:$nDigitsForComparison, n: ${forwardNumber.toRadixString(base)}, m: ${reversedNumber.toRadixString(base)},  ${wholeNumberMultiple.toRadixString(base)} * ${forwardNumber.toRadixString(base)} == ${reversedNumber.toRadixString(base)}");
    List<String> triple = [forwardNumber.toRadixString(base), reversedNumber.toRadixString(base), wholeNumberMultiple.toRadixString(base)];
    return triple;
//    List<String> triple = new List<String>(3);
//    triple[0] = forwardNumber.toRadixString(base);
//    triple[1] = reversedNumber.toRadixString(base);
//    triple[2] = wholeNumberMultiple.toRadixString(base);
//    return triple;
  }
}

