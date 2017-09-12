import 'dart:math';

List<int> digits;

//main(List<String> arguments) async {
main(List<String> arguments) {
  int minDigitsForComparison = 4;
  int maxDigitsForComparison = 5;
  int minBase = 10;
  int maxBase = 10;
  print("Starting at " + (new DateTime.now()).toString());
  Stopwatch stopWatch = new Stopwatch();
  for (int base = minBase; base <= maxBase; base++) {
    for (int nDigitsForComparison = minDigitsForComparison; nDigitsForComparison <= maxDigitsForComparison; nDigitsForComparison++) {
      stopWatch.start();
      digits = new List<int>.filled(nDigitsForComparison, 0);
      //await generateDigitsRecursively(base, nDigitsForComparison, 0);
      generateDigitsRecursively(base, nDigitsForComparison, 0);
      stopWatch.stop();
      print("\tProcessed ${nDigitsForComparison}-digit numbers in base $base in ${stopWatch.elapsed.inMilliseconds} milliseconds.");
      stopWatch.reset();
    }
  }
  print("Finished at " + (new DateTime.now()).toString());
}

//generateDigitsRecursively(int base, int nDigitsForComparison, int digitPosition) async {
generateDigitsRecursively(int base, int nDigitsForComparison, int digitPosition) {
  for (int digitValue = 0; digitValue < base; digitValue++) {
    digits[digitPosition] = digitValue;
    if (digitPosition == 0 && digits[0] == 0) {
      continue; // skip all numbers where leftmost digit is 0
    }
    if (digitPosition < nDigitsForComparison - 1) {
      generateDigitsRecursively(base, nDigitsForComparison, digitPosition + 1);
    }
    else {
      List<int> forwardNumberList = digits;
      List<int> reversedNumberList = new List<int>.from(digits.reversed);
      if (reversedNumberList[0] == 0) {
        continue; // skip numbers not right size
      }
      int forwardNumber = 0;
      int reversedNumber = 0;
      for (int digitPositionCtr = 0; digitPositionCtr < nDigitsForComparison; digitPositionCtr++) {
        forwardNumber = forwardNumber + forwardNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison -digitPositionCtr - 1);
        reversedNumber = reversedNumber + reversedNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison -digitPositionCtr - 1);
      }
      if (forwardNumber == reversedNumber) {
        continue; // skip numbers where multiple is 1
      }
      int mDivNRemainder = reversedNumber % forwardNumber;
      if (mDivNRemainder == 0) {
        int wholeNumberMultiple = reversedNumber ~/ forwardNumber;
        print("Base $base, digits:$nDigitsForComparison, n: ${forwardNumber.toRadixString(base)}, m: ${reversedNumber.toRadixString(base)},  ${wholeNumberMultiple.toRadixString(base)} * ${forwardNumber.toRadixString(base)} == ${reversedNumber.toRadixString(base)}");
        continue;
      }
    }
  }
  //print("Leaving generateDigitsRecursively");
}
