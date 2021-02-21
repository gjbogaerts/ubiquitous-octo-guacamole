abstract class ValidatorAbstract {
  String checkRegex(String val, RegExp regex, {msg});
  String minLength(String val, int min, {msg});
  String maxLength(String val, int max, {msg});
  String notEmpty(String val, {msg});
  String minVal(double val, double min, {msg});
  String maxVal(double val, double max, {msg});
  String doValidations(List<Map<Function, List<dynamic>>> validators);
}
