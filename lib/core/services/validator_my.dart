import 'validator_abstract.dart';

class MyValidator extends ValidatorAbstract {
  List<String> _errors = [];

  /// Performs a series of validations.
  ///
  /// Returns a String of errors, separated by a newline character.
  /// Takes a List of functions to call, mapped with their respective arguments, both positional and named
  ///
  String doValidations(List<Map<Function, List<dynamic>>> validators) {
    for (var validator in validators) {
      validator.forEach((Function fnc, List args) {
        Function.apply(fnc, args[0], args[1] ?? {});
      });
    }

    if (_errors.length == 0) {
      return null;
    }
    var tmp = _errors.toSet().toList();
    return tmp.join('\n');
  }

  @override
  String checkRegex(String val, RegExp regex,
      {msg =
          'De waarde die je hebt ingevuld is niet volgens het juiste formaat.'}) {
    if (!regex.hasMatch(val)) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String maxLength(String val, int max,
      {msg = 'De waarde die je hebt ingevuld is te lang.'}) {
    if (val.length > max) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String maxVal(double val, double max,
      {msg = 'Je hebt een te groot getal ingevuld'}) {
    if (val > max) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String minLength(String val, int min,
      {msg = 'De waarde die je hebt ingevuld is te kort.'}) {
    if (val.length < min) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String minVal(double val, double min,
      {msg = 'Je hebt een te klein getal ingevuld'}) {
    // print('minVal | $val - $min');
    if (val < min) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String notEmpty(String val, {msg = 'Dit is een verplicht veld.'}) {
    if (val == null || val.isEmpty) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }

  @override
  String intOnly(String val,
      {msg = 'Je moet hier een geheel getal invoeren.'}) {
    if (int.tryParse(val) == null) {
      _errors.add(msg);
      return msg;
    }
    return null;
  }
}
