import 'dart:math';

//main(List<String> arguments) async {
main(List<String> arguments) {
  int minDigitsForComparison = 4;
  int maxDigitsForComparison = 4;
  int minBase = 10;
  int maxBase = 10;
  print("Starting at " + (new DateTime.now()).toString());
  Stopwatch stopWatch = new Stopwatch();
  for (int base = minBase; base <= maxBase; base++) {
    for (int nDigitsForComparison = minDigitsForComparison; nDigitsForComparison <= maxDigitsForComparison; nDigitsForComparison++) {
      stopWatch.start();
      List<int> digits = new List<int>.filled(nDigitsForComparison, 0);
//      await generateDigitsRecursively(digits, base, nDigitsForComparison, 0);
      generateDigitsRecursively(digits, 0, base, nDigitsForComparison); // left to right, start with 0 position
      stopWatch.stop();
      print("\tProcessed ${nDigitsForComparison}-digit numbers in base $base in ${stopWatch.elapsed.inMilliseconds} milliseconds.");
      stopWatch.reset();
    }
  }
  print("Finished at " + (new DateTime.now()).toString());
}

// Don't get confused: "digits" is an array of numbers, where index 0 is the RIGHTMOST digit
//generateDigitsRecursively(List<int> digits, int base, int nDigitsForComparison, int digitPosition) async {
generateDigitsRecursively(List<int> digits, int digitPosition, int base, int nDigitsForComparison) {
  //print("In generateDigitsRecursively");
  for (int digitValue = 0; digitValue < base; digitValue++) {
    digits[digitPosition] = digitValue; // positions are numbered right to left starting with 0
    if (digitPosition == 0 && digits[0] == 0) {
    //if (digitPosition == 0 && (digits[0] == 0 || digits[nDigitsForComparison - 1] == 0)) {
      //print("Skipping digits starting with 0: ${digits.toString()}");
      continue; // skip all forward numbers where leftmost digit is 0
    }
    if (digitPosition < nDigitsForComparison - 1) {
      generateDigitsRecursively(digits, digitPosition + 1, base, nDigitsForComparison);
    }
    else {
      // Instead of checking digits at this point, we should just return them, and let parent check them
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
  //print("forward: ${forwardNumberList.toString()}");
  List<int> reversedNumberList = new List<int>.from(digits.reversed);
  //print("forward:reversed -- ${forwardNumberList.toString()}:${reversedNumberList.toString()}");
  // reject reversed digits starting with 0 because wrong size.
  if (reversedNumberList[0] == 0) {
    //print("Rejecting reversed number starting with 0: ${reversedNumberList.toString()}");
    return null;
  }
  // Convert digit position values to a number
  int forwardNumber = 0;
  int reversedNumber = 0;
  for (int digitPositionCtr = 0; digitPositionCtr < nDigitsForComparison; digitPositionCtr++) {
    forwardNumber = forwardNumber + forwardNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
    reversedNumber = reversedNumber + reversedNumberList.elementAt(digitPositionCtr) * pow(base, nDigitsForComparison - digitPositionCtr - 1);
  }
  // if the division would be less than or equal to 1, reject.
  if (forwardNumber >= reversedNumber) {
    return null;
  }
  // Check for modulo of 0
  int mDivNRemainder = reversedNumber % forwardNumber;
  if (mDivNRemainder == 0) {
    int wholeNumberMultiple = reversedNumber ~/ forwardNumber;
    List<String> triple = [forwardNumber.toRadixString(base), reversedNumber.toRadixString(base), wholeNumberMultiple.toRadixString(base)];
    return triple;
  }
}

